import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class Example extends StatelessWidget {
  final Widget field;
  final String title;
  final String? subTitle;
  final bool divider;
  final FormeKey formeKey;
  final String name;
  final List<Widget> buttons;

  const Example({
    Key? key,
    required this.field,
    required this.title,
    this.subTitle,
    this.divider = true,
    required this.formeKey,
    required this.name,
    this.buttons = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> allButton = [
      TextButton(
          onPressed: () {
            formeKey.field(name).reset();
          },
          child: const Text('reset')),
      Tooltip(
        message: 'will not work if no focusnode',
        textStyle: const TextStyle(color: Colors.orangeAccent),
        child: TextButton(
            onPressed: () {
              formeKey.field(name).focusNode?.requestFocus();
            },
            child: const Text('focus')),
      ),
      Tooltip(
        message: 'will not work if no focusnode',
        textStyle: const TextStyle(color: Colors.orangeAccent),
        child: TextButton(
            onPressed: () {
              formeKey.field(name).focusNode?.unfocus();
            },
            child: const Text('unfocus')),
      ),
      TextButton(
          onPressed: () {
            formeKey.field(name).readOnly = true;
          },
          child: const Text('read-only')),
      TextButton(
          onPressed: () {
            formeKey.field(name).readOnly = false;
          },
          child: const Text('editable')),
      TextButton(
          onPressed: () {
            formeKey.field(name).enabled = true;
          },
          child: const Text('enabled')),
      TextButton(
          onPressed: () {
            formeKey.field(name).enabled = false;
          },
          child: const Text('disabled')),
      Tooltip(
        message: 'will not work if no validators',
        textStyle: const TextStyle(color: Colors.orangeAccent),
        child: TextButton(
            onPressed: () {
              formeKey.field(name).validate(quietly: false);
            },
            child: const Text('validate')),
      ),
      ...buttons,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 32),
        ),
        if (subTitle != null) const SizedBox(height: 5),
        if (subTitle != null)
          Text(
            subTitle!,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            field,
            const SizedBox(height: 5),
            Builder(builder: (context) {
              final FormeFieldController controller = formeKey.field(name);
              return ValueListenableBuilder(
                  valueListenable: controller.valueListenable,
                  builder: (context, value, child) {
                    return Text(
                        'value changed , old value:${controller.oldValue} , new value:$value');
                  });
            }),
            Builder(builder: (context) {
              final FormeFieldController controller = formeKey.field(name);
              return ValueListenableBuilder(
                  valueListenable: controller.focusListenable,
                  builder: (context, value, child) {
                    return Text('focus changed , is focused: $value');
                  });
            }),
            Builder(builder: (context) {
              final FormeFieldController controller = formeKey.field(name);
              return ValueListenableBuilder<FormeFieldValidation>(
                  valueListenable: controller.validationListenable,
                  builder: (context, value, child) {
                    return Text('validation changed , current:($value)');
                  });
            }),
            Builder(builder: (context) {
              final FormeFieldController controller = formeKey.field(name);
              return ValueListenableBuilder<bool>(
                  valueListenable: controller.readOnlyListenable,
                  builder: (context, value, child) {
                    return Text('read-only state changed , current:$value');
                  });
            }),
            Builder(builder: (context) {
              final FormeFieldController controller = formeKey.field(name);
              return ValueListenableBuilder<bool>(
                  valueListenable: controller.enabledListenable,
                  builder: (context, value, child) {
                    return Text('enable state changed , current:$value');
                  });
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
        if (divider) const Divider(),
      ],
    );
  }
}
