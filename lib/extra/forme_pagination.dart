import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forme_searchable/forme_searchable.dart';

class FormePaginationButton extends StatefulWidget {
  final Widget child;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final Duration? clickAnimateDuration;
  final Offset? clickAnimateOffset;
  final Color? shadowColor;
  final bool enableShadow;
  final VoidCallback onPressed;

  const FormePaginationButton({
    required this.child,
    required this.onPressed,
    this.color,
    this.borderRadius,
    Key? key,
    this.width,
    this.height,
    this.clickAnimateOffset,
    this.clickAnimateDuration,
    this.shadowColor,
    this.enableShadow = true,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FormePaginationButtonState();
}

class _FormePaginationButtonState extends State<FormePaginationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _listenable;
  late Tween<Offset> _tween;

  Duration get _animateDuration =>
      widget.clickAnimateDuration ?? const Duration(milliseconds: 80);
  Offset get _animateOffset => widget.clickAnimateOffset ?? const Offset(3, 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: _animateDuration,
    );
    _tween = Tween(begin: Offset.zero, end: _animateOffset);
    _listenable = _tween.animate(_controller)
      ..addStatusListener(_onStatusChange);
  }

  @override
  void didUpdateWidget(covariant FormePaginationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = _animateDuration;
    _tween.end = _animateOffset;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reset();
      if (_tween.begin == Offset.zero) {
        _tween.begin = _animateOffset;
        _tween.end = Offset.zero;
        _controller.forward(from: 0);
      } else {
        _tween.begin = Offset.zero;
        _tween.end = _animateOffset;
        widget.onPressed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        _controller.forward();
      },
      enableFeedback: false,
      child: AnimatedBuilder(
          animation: _listenable,
          builder: (context, child) {
            Offset offset = _listenable.value;
            return Transform.translate(
              offset: _listenable.value,
              child: Container(
                width: widget.width ?? 36,
                height: widget.height ?? 36,
                child: Center(
                  child: widget.child,
                ),
                decoration: BoxDecoration(
                  color: widget.color ?? Colors.white,
                  borderRadius: widget.borderRadius ??
                      const BorderRadius.all(Radius.circular(10)),
                  boxShadow: !widget.enableShadow
                      ? null
                      : [
                          BoxShadow(
                            color: widget.shadowColor ??
                                Colors.grey.withOpacity(0.5),
                            offset: Offset(
                                _animateOffset.dx - offset.dx,
                                _animateOffset.dy -
                                    offset.dy), // changes position of shadow
                          ),
                        ],
                ),
              ),
            );
          }),
    );
  }
}

class FormePagination extends StatefulWidget {
  final ValueChanged<int> onPageChanged;
  final ValueListenable<PageInfo> notifier;
  final int maxPageButtons;

  /// current page  10
  ///  if [leftButtons] is 5
  ///
  /// 5 6 7 8 9 10 11 12 13 14
  ///
  ///  if [leftButtons] is 4
  ///
  ///  6 7 8 9 10 11 12 13 14 15
  ///
  ///
  /// default is 5
  final int leftButtons;

  final Color? buttonColor;
  final BorderRadius? buttonBorderRadius;
  final double? buttonWidth;
  final double? buttonHeight;
  final Duration? buttonClickAnimateDuration;
  final Offset? buttonClickAnimateOffset;
  final TextStyle? buttonTextStyle;
  final Color? buttonShadowColor;
  final bool enableButtonShadow;

  final bool prevButton;
  final bool nextButton;

  final Color? buttonActiveColor;

  const FormePagination({
    Key? key,
    required this.onPageChanged,
    required this.notifier,
    this.maxPageButtons = 10,
    this.leftButtons = 5,
    this.buttonColor,
    this.buttonBorderRadius,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonClickAnimateOffset,
    this.buttonClickAnimateDuration,
    this.buttonTextStyle,
    this.buttonShadowColor,
    this.enableButtonShadow = true,
    this.prevButton = true,
    this.nextButton = true,
    this.buttonActiveColor,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FormePaginationState();
}

class _FormePaginationState extends State<FormePagination> {
  late int _currentPage;

  int get _totalPage => widget.notifier.value.totalPage;
  bool get _hasPrevPage => widget.prevButton && _currentPage > 1;
  bool get _hasNextPage => widget.nextButton && _currentPage < _totalPage;

  @override
  void initState() {
    _currentPage = widget.notifier.value.currentPage;
    widget.notifier.addListener(_onPageInfoChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onPageInfoChanged);
    super.dispose();
  }

  void _onPageInfoChanged() {
    setState(() {
      _currentPage = widget.notifier.value.currentPage;
    });
  }

  ///https://stackoverflow.com/a/11274294/7514037
  List<int> get _pageArray {
    int startPage = _currentPage < widget.leftButtons + 1
        ? 1
        : _currentPage - widget.leftButtons;
    int endPage = widget.maxPageButtons - 1 + startPage;
    endPage = _totalPage < endPage ? _totalPage : endPage;
    int diff = startPage - endPage + widget.maxPageButtons - 1;
    startPage -= startPage - diff > 0 ? diff : 0;
    final List<int> result = [];
    for (int i = startPage; i <= endPage; i++) {
      result.add(i);
    }
    return result;
  }

  FormePaginationButton _buildButton(int page, [Widget? child]) {
    return FormePaginationButton(
      color: page == _currentPage
          ? widget.buttonActiveColor ?? widget.buttonColor
          : widget.buttonColor,
      borderRadius: widget.buttonBorderRadius,
      width: widget.buttonWidth,
      height: widget.buttonHeight,
      shadowColor: widget.buttonShadowColor,
      enableShadow: widget.enableButtonShadow,
      clickAnimateDuration: widget.buttonClickAnimateDuration,
      clickAnimateOffset: widget.buttonClickAnimateOffset,
      child: child ??
          Text(
            '$page',
            style: widget.buttonTextStyle,
          ),
      onPressed: () {
        widget.onPageChanged(page);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = _pageArray.map((e) {
      return _buildButton(e);
    }).toList();
    if (_hasPrevPage) {
      buttons.insert(0,
          _buildButton(_currentPage - 1, const Icon(Icons.arrow_left_sharp)));
    }
    if (_hasNextPage) {
      buttons.add(
          _buildButton(_currentPage + 1, const Icon(Icons.arrow_right_sharp)));
    }
    return Center(
      child: Wrap(
        spacing: 10,
        children: buttons,
      ),
    );
  }
}
