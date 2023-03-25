import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';

class FluentExample extends StatelessWidget {
  final Widget field;
  final String title;
  final String? subTitle;
  final FormeKey formeKey;
  final String name;
  final List<Widget> buttons;

  const FluentExample({
    Key? key,
    required this.field,
    required this.title,
    this.subTitle,
    required this.formeKey,
    required this.name,
    this.buttons = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> allButton = [
      Button(
          onPressed: () {
            formeKey.field(name).reset();
          },
          child: const Text('reset')),
      Button(
          onPressed: () {
            FormeFieldState field = formeKey.field(name);
            if (field.hasFocusNode) {
              field.focusNode.requestFocus();
            }
          },
          child: const Text('focus')),
      Button(
          onPressed: () {
            FormeFieldState field = formeKey.field(name);
            if (field.hasFocusNode) {
              field.focusNode.unfocus();
            }
          },
          child: const Text('unfocus')),
      FormeFieldStatusListener(
          filter: (status) => status.isReadOnlyChanged,
          builder: (context, status, child) {
            if (status == null) {
              return const SizedBox.shrink();
            }
            return Button(
                onPressed: () {
                  formeKey.field(name).readOnly = !status.readOnly;
                },
                child: Text(status.readOnly ? 'editable' : 'read-only'));
          },
          name: name),
      FormeFieldStatusListener(
          name: name,
          filter: (status) => status.isEnabledChanged,
          builder: (context, status, child) {
            if (status == null) {
              return const SizedBox.shrink();
            }
            return Button(
                onPressed: () {
                  formeKey.field(name).enabled = !status.enabled;
                },
                child: Text(status.enabled ? 'disabled' : 'enabled'));
          }),
      Builder(builder: (context) {
        if (formeKey.field(name).validation ==
            FormeFieldValidation.unnecessary) {
          return const SizedBox.shrink();
        }
        return Button(
            onPressed: () {
              formeKey.field(name).validate(quietly: false);
            },
            child: const Text('validate'));
      }),
      ...buttons,
    ];
    return FluentTheme(
      data: FluentThemeData(),
      child: Column(
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
              FormeFieldStatusListener(
                  name: name,
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
        ],
      ),
    );
  }
}
