import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import '../forme_screen.dart';

class FormeFluentToggleSwitchScreen extends FormeScreen {
  FormeFluentToggleSwitchScreen({Key? key})
      : super(
            title: 'FormeFluentToggleSwitch',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'switch',
                  title: '',
                  field: FormeFluentToggleSwitch(
                    name: 'switch',
                    content: FormeFieldStatusListener<bool>(
                      filter: (status) => status.isValueChanged,
                      builder: (context, status, child) {
                        if (status != null) {
                          bool? checked = status.value;
                          return Text(
                            checked ? 'on' : 'off',
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    validator:
                        FormeValidates.equals(true, errorText: 'turn on pls'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decorator: FormeFieldDecoratorBuilder(
                        buider: (context, child, field) {
                      String? errorText = field.errorText;
                      return Row(
                        children: [
                          child,
                          errorText == null
                              ? const SizedBox.shrink()
                              : Text(
                                  errorText,
                                  style: const TextStyle(
                                      color: Colors.warningPrimaryColor),
                                ),
                        ],
                      );
                    }),
                  ),
                  buttons: [
                    Button(
                        child: const Text('on'),
                        onPressed: () {
                          key.field('switch').value = true;
                        }),
                    Button(
                        child: const Text('off'),
                        onPressed: () {
                          key.field('switch').value = false;
                        })
                  ],
                ),
              ];
            });
}
