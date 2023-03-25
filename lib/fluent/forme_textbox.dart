import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import '../forme_screen.dart';

class FormeFluentTextBoxScreen extends FormeScreen {
  FormeFluentTextBoxScreen({Key? key})
      : super(
            title: 'FormeFluentTextBoxScreen',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'textbox',
                  title: 'Basic',
                  field: FormeFluentTextBox(
                    name: 'textbox',
                    validator: FormeValidates.notEmpty(errorText: 'required'),
                    asyncValidator: (field, value, isValid) async {
                      return Future.delayed(const Duration(seconds: 2), () {
                        if (value.length < 10) {
                          return 'length > 10';
                        }
                        return null;
                      });
                    },
                    suffix: FormeFieldStatusListener<String>(
                      filter: (status) => status.isValidationChanged,
                      builder: (context, status, child) {
                        if (status == null) {
                          return const SizedBox.shrink();
                        }
                        if (status.validation.isValidating) {
                          return const SizedBox(
                            width: 16,
                            height: 16,
                            child: ProgressRing(),
                          );
                        }

                        if (status.validation.isValid) {
                          return const Icon(
                            FluentIcons.accept,
                            color: Colors.successPrimaryColor,
                          );
                        }

                        if (status.validation.isInvalid) {
                          return const Icon(
                            FluentIcons.critical_error_solid,
                            color: Colors.errorPrimaryColor,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decorator: const FormeFluentFormRowDecorator.noPadding(),
                  ),
                  buttons: [
                    Button(
                      child: const Text('select all'),
                      onPressed: () {
                        (key.field('textbox') as FormeFluentTextBoxState)
                                .textEditingController
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset:
                                    (key.field('textbox').value as String)
                                        .length);
                        key.field('textbox').focusNode.requestFocus();
                      },
                    ),
                  ],
                ),
                FluentExample(
                  name: 'obscureText',
                  formeKey: key,
                  title: 'ObscureText',
                  field: FormeFluentTextBox(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'obscureText',
                    maxLength: 20,
                    autofocus: true,
                  ),
                ),
                FluentExample(
                  formeKey: key,
                  title: 'Textarea',
                  name: 'textarea',
                  field: FormeFluentTextBox(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'textarea',
                      maxLength: 200,
                      maxLines: 10,
                      autofocus: true),
                ),
              ];
            });
}
