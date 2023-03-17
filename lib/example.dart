import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class Example extends StatefulWidget {
  final FormeField field;
  final String title;
  final String? subTitle;
  final bool divider;
  final FormeKey formeKey;
  final List<Widget> buttons;

  const Example({
    Key? key,
    required this.field,
    required this.title,
    this.subTitle,
    this.divider = true,
    required this.formeKey,
    this.buttons = const [],
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    List<Widget> allButton = [
      TextButton(
          onPressed: () {
            widget.formeKey.field(widget.field.name!).reset();
          },
          child: const Text('reset')),
      Tooltip(
        message: 'will not work if no focusnode',
        textStyle: const TextStyle(color: Colors.orangeAccent),
        child: TextButton(
            onPressed: () {
              FormeFieldState state = widget.formeKey.field(widget.field.name!);
              if (state.hasFocusNode) {
                state.focusNode.requestFocus();
              }
            },
            child: const Text('focus')),
      ),
      Tooltip(
        message: 'will not work if no focusnode',
        textStyle: const TextStyle(color: Colors.orangeAccent),
        child: TextButton(
            onPressed: () {
              FormeFieldState state = widget.formeKey.field(widget.field.name!);

              if (state.hasFocusNode) {
                state.focusNode.unfocus();
              }
            },
            child: const Text('unfocus')),
      ),
      FormeFieldStatusListener(
          filter: (status) => status.isReadOnlyChanged,
          builder: (context, status, child) {
            if (status == null) {
              return const SizedBox.shrink();
            }
            return TextButton(
                onPressed: () {
                  widget.formeKey.field(widget.field.name!).readOnly =
                      !status.readOnly;
                },
                child: Text(status.readOnly ? 'editable' : 'read-only'));
          },
          name: widget.field.name),
      FormeFieldStatusListener(
          name: widget.field.name,
          filter: (status) => status.isEnabledChanged,
          builder: (context, status, child) {
            if (status == null) {
              return const SizedBox.shrink();
            }
            return TextButton(
                onPressed: () {
                  widget.formeKey.field(widget.field.name!).enabled =
                      !status.enabled;
                },
                child: Text(status.enabled ? 'disabled' : 'enabled'));
          }),
      Builder(builder: (context) {
        if (widget.formeKey.field(widget.field.name!).validation ==
            FormeFieldValidation.unnecessary) {
          return const SizedBox.shrink();
        }
        return TextButton(
            onPressed: () {
              widget.formeKey
                  .field(widget.field.name!)
                  .validate(quietly: false);
            },
            child: const Text('validate'));
      }),
      ...widget.buttons,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 32),
        ),
        if (widget.subTitle != null) const SizedBox(height: 5),
        if (widget.subTitle != null)
          Text(
            widget.subTitle!,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.field,
            const SizedBox(height: 5),
            FormeFieldStatusListener(
                name: widget.field.name,
                builder: (context, status, child) {
                  if (status == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      Text('value:${status.value}'),
                      Text('read-only:${status.readOnly}'),
                      Text('enabled:${status.enabled}'),
                      Text('validation:${status.validation}'),
                      Text('isFocused:${status.hasFocus}'),
                    ],
                  );
                }),
            const SizedBox(height: 5),
            Wrap(
              children: allButton,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (widget.divider) const Divider(),
      ],
    );
  }
}
