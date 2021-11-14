import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeAsyncInputChipScreen extends FormeScreen {
  static Future<Iterable<String>> optionsBuilder(TextEditingValue value) =>
      Future.delayed(
          const Duration(milliseconds: 500),
          () => List.generate(100, (index) => '$index')
              .where((element) => element.contains(value.text)));

  static Widget inputChipBuilder(option, onDeleted) {
    return InputChip(
      label: Text(option),
      avatar: const FlutterLogo(),
      onDeleted: onDeleted,
    );
  }

  static String? validator(controller, List value) {
    return value.length < 2 ? 'invalid' : null;
  }

  static Future<String?> asyncValidator(controller, List value) {
    return Future.delayed(const Duration(milliseconds: 600), () {
      return value.length > 3 ? 'invalid' : null;
    });
  }

  FormeAsyncInputChipScreen({Key? key})
      : super(
            key: key,
            title: 'FormeAsyncInputChip',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'asyncInputChip',
                  field: FormeAsyncInputChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
                    onInitialed: (f) {
                      FormeAsyncInputChipController controller =
                          f as FormeAsyncInputChipController;
                      controller.optionsViewVisibeStateListenable
                          .addListener(() {
                        if (controller.isOptionsViewVisible) {
                          SystemChannels.textInput
                              .invokeMethod<Object>('TextInput.hide');
                        }
                      });
                    },
                    asyncValidator: asyncValidator,
                    inputChipBuilder: inputChipBuilder,
                    decoration: const InputDecoration(
                        labelText: 'FormeAsyncInputChip',
                        suffixIconConstraints: BoxConstraints.tightFor()),
                    name: 'asyncInputChip',
                    optionsBuilder: optionsBuilder,
                  ),
                  title: 'FormeAsyncInputChip',
                ),
                Example(
                  formeKey: key,
                  name: 'asyncInputChip2',
                  subTitle: 'custom field view',
                  field: FormeAsyncInputChip<String>(
                    fieldViewBuilder: (context, selected, controller,
                        textEditingController, focusNode, onSubmitted) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: selected
                                .map(
                                  (e) => InputChip(
                                    label: Text(e),
                                    onDeleted: controller.readOnly
                                        ? null
                                        : () {
                                            controller.delete(e);
                                          },
                                  ),
                                )
                                .toList(),
                          ),
                          TextField(
                            decoration: null,
                            focusNode: focusNode,
                            controller: textEditingController,
                            onSubmitted:
                                controller.readOnly ? null : (v) => onSubmitted,
                          ),
                        ],
                      );
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
                    asyncValidator: asyncValidator,
                    inputChipBuilder: inputChipBuilder,
                    decoration: const InputDecoration(
                        labelText: 'FormeAsyncInputChip',
                        suffixIconConstraints: BoxConstraints.tightFor()),
                    name: 'asyncInputChip2',
                    optionsBuilder: optionsBuilder,
                  ),
                  title: 'FormeAsyncInputChip2',
                ),
                Example(
                  formeKey: key,
                  name: 'asyncInputChip3',
                  subTitle: 'custom state icon',
                  field: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormeAsyncInputChip<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validator,
                        asyncValidator: asyncValidator,
                        inputChipBuilder: inputChipBuilder,
                        decoration: const InputDecoration(
                          labelText: 'FormeAsyncInputChip',
                          suffixIconConstraints: BoxConstraints.tightFor(),
                          suffixIcon: SizedBox.shrink(),
                        ),
                        name: 'asyncInputChip3',
                        optionsBuilder: optionsBuilder,
                      ),
                      Builder(builder: (context) {
                        FormeAsyncInputChipController controller =
                            key.field('asyncInputChip3');

                        return ValueListenableBuilder2<bool,
                                FormeAsyncAutocompleteSearchState>(
                            controller.optionsViewVisibeStateListenable,
                            controller.stateListenable,
                            builder: (context, visible, state, child) {
                          if (state ==
                                  FormeAsyncAutocompleteSearchState.loading &&
                              !visible) {
                            return Material(
                              elevation: 4.0,
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 200),
                                child: const Text('loading'),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }),
                    ],
                  ),
                  title: 'FormeAsyncInputChip3',
                ),
              ];
            });
}

typedef FormeAsyncInputChipFieldViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  List<T> selected,
  FormeAsyncInputChipController<T> controller,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onSubmitted,
);

typedef FormeAsyncInputChipBuilder<T> = Widget Function(
    T option, VoidCallback? onDelete);

class FormeAsyncInputChip<T extends Object> extends FormeField<List<T>> {
  final AutocompleteOptionToString<T> displayStringForOption;

  /// async loader debounce
  final Duration? debounce;

  final FormeAsyncAutocompleteOptionsBuilder<T> optionsBuilder;

  final double optionsMaxHeight;

  /// whether perform a search with current input
  ///
  /// return false means **DO NOT** perform a search and will clear prev options immediately
  final FormeSearchCondition? searchCondition;

  FormeAsyncInputChip({
    List<T> initialValue = const [],
    required String name,
    bool readOnly = false,
    Key? key,
    int? order,
    bool quietlyValidate = false,
    Duration? asyncValidatorDebounce,
    AutovalidateMode? autovalidateMode,
    FormeValueChanged<List<T>>? onValueChanged,
    FormeFocusChanged<List<T>>? onFocusChanged,
    FormeFieldSetter<List<T>>? onSaved,
    FormeValidator<List<T>>? validator,
    FormeAsyncValidator<List<T>>? asyncValidator,
    FormeFieldValidationChanged<List<T>>? onValidationChanged,
    FormeFieldInitialed<List<T>>? onInitialed,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    FormeAsyncInputChipFieldViewBuilder<T>? fieldViewBuilder,
    FormeAutocompleteOptionsViewBuilder<T>? optionsViewBuilder,
    this.optionsMaxHeight = 200,
    InputDecoration? decoration,
    int? maxLines = 1,
    TextInputType? keyboardType,
    bool autofocus = false,
    int? minLines,
    int? maxLength,
    TextStyle? style,
    ToolbarOptions? toolbarOptions,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    bool expands = false,
    MaxLengthEnforcement? maxLengthEnforcement,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    BoxHeightStyle selectionHeightStyle = BoxHeightStyle.tight,
    BoxWidthStyle selectionWidthStyle = BoxWidthStyle.tight,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    MouseCursor? mouseCursor,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    bool enableInteractiveSelection = true,
    bool enabled = true,
    VoidCallback? onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    AppPrivateCommandCallback? appPrivateCommandCallback,
    InputCounterWidgetBuilder? buildCounter,
    GestureTapCallback? onTap,
    ScrollController? scrollController,
    TextSelectionControls? textSelectionControls,
    bool enableIMEPersonalizedLearning = true,
    this.debounce,
    required this.optionsBuilder,
    this.searchCondition,

    /// **this decorator is used to decorate fieldView Only**
    FormeFieldDecorator<List<T>>? decorator,
    bool registrable = true,
    InputDecoration? searchInputDecoration,
    Axis wrapDirection = Axis.horizontal,
    WrapAlignment wrapAlignment = WrapAlignment.start,
    double wrapSpacing = 4.0,
    WrapAlignment wrapRunAlignment = WrapAlignment.start,
    double wrapRunSpacing = 0.0,
    WrapCrossAlignment wrapCrossAxisAlignment = WrapCrossAlignment.center,
    TextDirection? wrapTextDirection,
    VerticalDirection wrapVerticalDirection = VerticalDirection.down,
    Clip wrapClipBehavior = Clip.none,
    double? searchInputStepWidth,
    double searchInputMinWidth = 50,
    FormeAsyncInputChipBuilder<T>? inputChipBuilder,
  }) : super(
          onInitialed: onInitialed,
          registrable: registrable,
          order: order,
          quietlyValidate: quietlyValidate,
          asyncValidatorDebounce: asyncValidatorDebounce,
          autovalidateMode: autovalidateMode,
          onValueChanged: onValueChanged,
          onFocusChanged: onFocusChanged,
          onValidationChanged: onValidationChanged,
          onSaved: onSaved,
          validator: validator,
          asyncValidator: asyncValidator,
          key: key,
          readOnly: readOnly,
          name: name,
          initialValue: initialValue,
          builder: (genericState) {
            final _FormeAsyncInputChipState<T> state =
                genericState as _FormeAsyncInputChipState<T>;
            final bool readOnly = state.readOnly;
            return RawAutocomplete<T>(
              focusNode: state.focusNode,
              textEditingController: state.textEditingController,
              onSelected: (T t) {
                final List<T> value = List.of(state.value);
                if (!value.contains(t)) {
                  value.add(t);
                  state.didChange(value);
                }
                state.effectiveController.text = '';
                state.clearOptionsAndWaiting();
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
                state.optionsViewVisibleStateNotifier.value = true;
                return ValueListenableBuilder<double?>(
                    valueListenable: state.optionsViewWidthNotifier,
                    builder: (context, width, _child) {
                      return optionsViewBuilder?.call(
                              context, onSelected, state.options, width) ??
                          AutocompleteOptions(
                            displayStringForOption: displayStringForOption,
                            onSelected: onSelected,
                            options: state.options,
                            maxOptionsHeight: optionsMaxHeight,
                            width: width,
                          );
                    });
              },
              optionsBuilder: (TextEditingValue value) {
                if (state.success) {
                  return state.options;
                }
                return const Iterable.empty();
              },
              displayStringForOption: displayStringForOption,
              fieldViewBuilder:
                  (context, textEditingController, focusNode, onSubmitted) {
                Widget field;
                if (fieldViewBuilder != null) {
                  field = fieldViewBuilder(
                      context,
                      state.value,
                      state.controller as FormeAsyncInputChipController<T>,
                      state.effectiveController,
                      focusNode,
                      onSubmitted);
                } else {
                  field = TextField(
                    decoration: searchInputDecoration,
                    enableIMEPersonalizedLearning:
                        enableIMEPersonalizedLearning,
                    focusNode: focusNode,
                    controller: state.effectiveController,
                    obscureText: obscureText,
                    maxLines: maxLines,
                    minLines: minLines,
                    enabled: enabled,
                    readOnly: readOnly,
                    onTap: onTap,
                    onEditingComplete: onEditingComplete,
                    onSubmitted: readOnly
                        ? null
                        : (v) {
                            onSubmitted();
                          },
                    onAppPrivateCommand: appPrivateCommandCallback,
                    textInputAction: textInputAction,
                    textCapitalization: textCapitalization,
                    style: style,
                    strutStyle: strutStyle,
                    textAlign: textAlign,
                    textAlignVertical: textAlignVertical,
                    textDirection: textDirection,
                    showCursor: showCursor,
                    obscuringCharacter: obscuringCharacter,
                    autocorrect: autocorrect,
                    smartDashesType: smartDashesType,
                    smartQuotesType: smartQuotesType,
                    enableSuggestions: enableSuggestions,
                    expands: expands,
                    cursorWidth: cursorWidth,
                    cursorHeight: cursorHeight,
                    cursorRadius: cursorRadius,
                    cursorColor: cursorColor,
                    selectionHeightStyle: selectionHeightStyle,
                    selectionWidthStyle: selectionWidthStyle,
                    keyboardAppearance: keyboardAppearance,
                    scrollPadding: scrollPadding,
                    dragStartBehavior: dragStartBehavior,
                    mouseCursor: mouseCursor,
                    scrollPhysics: scrollPhysics,
                    autofillHints: autofillHints,
                    autofocus: autofocus,
                    toolbarOptions: toolbarOptions,
                    enableInteractiveSelection: enableInteractiveSelection,
                    buildCounter: buildCounter,
                    maxLengthEnforcement: maxLengthEnforcement,
                    inputFormatters: inputFormatters,
                    keyboardType: keyboardType,
                    maxLength: maxLength,
                    scrollController: scrollController,
                    selectionControls: textSelectionControls,
                  );

                  field = Wrap(
                    direction: wrapDirection,
                    alignment: wrapAlignment,
                    runAlignment: wrapRunAlignment,
                    runSpacing: wrapRunSpacing,
                    spacing: wrapSpacing,
                    crossAxisAlignment: wrapCrossAxisAlignment,
                    textDirection: wrapTextDirection,
                    verticalDirection: wrapVerticalDirection,
                    clipBehavior: wrapClipBehavior,
                    children: state.value.map<Widget>((e) {
                      void onDeleted() {
                        state.delete(e);
                      }

                      if (inputChipBuilder != null) {
                        return inputChipBuilder(
                            e, state.readOnly ? null : onDeleted);
                      }

                      return InputChip(
                        label: Text(displayStringForOption(e)),
                        onDeleted: state.readOnly ? null : onDeleted,
                      );
                    }).toList()
                      ..add(
                        IntrinsicWidth(
                          stepWidth: searchInputStepWidth,
                          child: Container(
                            constraints:
                                BoxConstraints(minWidth: searchInputMinWidth),
                            child: field,
                          ),
                        ),
                      ),
                  );
                }
                return OrientationBuilder(builder: (context, orientation) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                    final RenderObject? renderObject =
                        context.findRenderObject();
                    if (renderObject != null && renderObject is RenderBox) {
                      state.optionsViewWidthNotifier.value =
                          renderObject.size.width;
                    }
                  });

                  final Widget stateIcon = Builder(
                    builder: (context) {
                      final FormeAsyncInputChipController<T> controller =
                          FormeField.of<List<T>>(context)!
                              as FormeAsyncInputChipController<T>;
                      return ValueListenableBuilder2<
                              FormeAsyncAutocompleteSearchState,
                              FormeFieldValidation>(controller.stateListenable,
                          controller.validationListenable,
                          builder: (context, state, validation, child) {
                        final bool loading = validation.isValidating ||
                            state == FormeAsyncAutocompleteSearchState.loading;
                        final bool error = validation.isFail ||
                            state == FormeAsyncAutocompleteSearchState.error;
                        if (loading) {
                          return const Padding(
                            padding: EdgeInsets.all(0),
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          );
                        }

                        if (error) {
                          return const Icon(
                            Icons.dangerous,
                            color: Colors.redAccent,
                          );
                        }

                        if (validation.isInvalid) {
                          return const Icon(
                            Icons.warning,
                            color: Colors.orangeAccent,
                          );
                        }

                        return const SizedBox.shrink();
                      });
                    },
                  );

                  final FormeFieldDecorator<List<T>>? finalDecorator =
                      decorator ??
                          (decoration == null
                              ? null
                              : FormeInputDecoratorBuilder(
                                  decoration: decoration.copyWith(
                                      suffixIcon:
                                          decoration.suffixIcon ?? stateIcon),
                                  emptyChecker: (value, controller) {
                                    return state.value.isEmpty &&
                                        (controller
                                                as FormeAsyncInputChipController<
                                                    T>)
                                            .textFieldController
                                            .text
                                            .isEmpty;
                                  }));

                  field = finalDecorator == null
                      ? field
                      : finalDecorator.build(state.controller, field);

                  if (fieldViewBuilder == null) {
                    field = GestureDetector(
                        onTap: () {
                          final bool needFocus = !state.focusNode.hasFocus;
                          if (needFocus) {
                            state.focusNode.requestFocus();
                          }
                          if (state.focusNode.hasFocus && !kIsWeb) {
                            SystemChannels.textInput
                                .invokeMethod<Object>('TextInput.show');
                          }
                        },
                        child: field);
                  }

                  return field;
                });
              },
            );
          },
        );

  @override
  FormeFieldState<List<T>> createState() => _FormeAsyncInputChipState();
}

class _FormeAsyncInputChipState<T extends Object>
    extends FormeFieldState<List<T>> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController effectiveController = TextEditingController();
  late final ValueNotifier<FormeAsyncAutocompleteSearchState> stateNotifier =
      FormeMountedValueNotifier(
          FormeAsyncAutocompleteSearchState.waiting, this);
  late final ValueNotifier<bool> optionsViewVisibleStateNotifier =
      FormeMountedValueNotifier(false, this);
  late final ValueNotifier<double?> optionsViewWidthNotifier =
      FormeMountedValueNotifier(null, this);

  int gen = 0;
  int optionsGen = 0;
  Iterable<T> options = [];
  Timer? debounce;
  String? oldTextValue;

  bool get success =>
      stateNotifier.value == FormeAsyncAutocompleteSearchState.success;
  bool get error =>
      stateNotifier.value == FormeAsyncAutocompleteSearchState.error;

  @override
  void afterInitiation() {
    super.afterInitiation();
    effectiveController.addListener(fieldChange);
  }

  bool searchCondition(TextEditingValue value) {
    if (value.text.isNotEmpty) {
      return widget.searchCondition?.call(value) ?? true;
    }
    return false;
  }

  void fieldChange() {
    final String text = effectiveController.text;
    if (oldTextValue != text) {
      oldTextValue = text;

      final bool performSearch = searchCondition(effectiveController.value);

      if (!performSearch) {
        clearOptionsAndWaiting();
        return;
      }

      queryOptions(effectiveController.value);
    }
  }

  @override
  FormeAsyncInputChip<T> get widget => super.widget as FormeAsyncInputChip<T>;

  void clearOptionsAndWaiting() {
    debounce?.cancel();
    options = [];
    optionsGen = ++gen;
    stateNotifier.value = FormeAsyncAutocompleteSearchState.waiting;
    updateTextEditingController();
    optionsViewVisibleStateNotifier.value = false;
  }

  @override
  void onFocusChanged(bool hasFocus) {
    super.onFocusChanged(hasFocus);
    if (!hasFocus) {
      optionsViewVisibleStateNotifier.value = false;
    }
  }

  void queryOptions(TextEditingValue value) {
    stateNotifier.value = FormeAsyncAutocompleteSearchState.loading;
    final int currentGen = ++gen;
    debounce?.cancel();
    debounce = Timer(widget.debounce ?? const Duration(milliseconds: 500), () {
      if (!mounted) {
        return;
      }
      widget.optionsBuilder(value).then((options) {
        if (currentGen == gen) {
          this.options =
              options.where((element) => !this.value.contains(element));
          optionsGen = gen;
        }
      }).whenComplete(() {
        if (currentGen == gen && mounted) {
          if (optionsGen == gen) {
            stateNotifier.value = FormeAsyncAutocompleteSearchState.success;
          } else {
            stateNotifier.value = FormeAsyncAutocompleteSearchState.error;
          }
          if (success) {
            updateTextEditingController();
          }
        }
      });
    });
  }

  void updateTextEditingController() {
    textEditingController.text = textEditingController.text == '' ? '*' : '';
  }

  @override
  void dispose() {
    debounce?.cancel();
    stateNotifier.dispose();
    optionsViewVisibleStateNotifier.dispose();
    optionsViewWidthNotifier.dispose();
    textEditingController.dispose();
    effectiveController.dispose();
    super.dispose();
  }

  @override
  set readOnly(bool readOnly) {
    super.readOnly = readOnly;

    if (readOnly) {
      clearOptionsAndWaiting();
    }
  }

  @override
  void reset() {
    debounce?.cancel();
    oldTextValue = null;
    options = [];
    optionsGen = ++gen;
    super.reset();
    stateNotifier.value = FormeAsyncAutocompleteSearchState.waiting;
    effectiveController.text = '';
  }

  @override
  FormeFieldController<List<T>> createFormeFieldController() {
    return FormeAsyncInputChipController._(
        super.createFormeFieldController(), this);
  }

  void delete(T option) {
    final List<T> value = List.of(this.value);
    if (value.remove(option)) {
      didChange(value);
    }
  }
}

class FormeAsyncInputChipController<T extends Object>
    extends FormeFieldControllerDelegate<List<T>> {
  final _FormeAsyncInputChipState<T> _state;
  final ValueListenable<FormeAsyncAutocompleteSearchState> stateListenable;
  final ValueListenable<bool> optionsViewVisibeStateListenable;
  FormeAsyncInputChipController._(
      FormeFieldController<List<T>> delegate, this._state)
      : stateListenable = FormeValueListenableDelegate(_state.stateNotifier),
        optionsViewVisibeStateListenable = FormeValueListenableDelegate(
            _state.optionsViewVisibleStateNotifier),
        super(delegate);

  /// get textFieldController used for Field view
  TextEditingController get textFieldController => _state.effectiveController;

  void delete(T option) {
    _state.delete(option);
  }

  bool get isOptionsViewVisible => optionsViewVisibeStateListenable.value;
}
