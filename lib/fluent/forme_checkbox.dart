import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import '../forme_screen.dart';

class FormeFluentCheckBoxScreen extends FormeScreen {
  FormeFluentCheckBoxScreen({Key? key})
      : super(
            title: 'FormeFluentCheckbox',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'checkbox',
                  title: '',
                  field: FormeFluentCheckbox(
                    name: 'checkbox',
                    content: FormeFieldStatusListener<bool>(
                      filter: (status) => status.isValueChanged,
                      builder: (context, status, child) {
                        if (status != null) {
                          bool? checked = status.value;
                          return Text(
                            checked ? 'checked' : 'unchecked',
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    validator:
                        FormeValidates.equals(true, errorText: 'check pls'),
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
                        child: const Text('check'),
                        onPressed: () {
                          key.field('checkbox').value = true;
                        }),
                    Button(
                        child: const Text('uncheck'),
                        onPressed: () {
                          key.field('checkbox').value = false;
                        })
                  ],
                ),
              ];
            });
}
