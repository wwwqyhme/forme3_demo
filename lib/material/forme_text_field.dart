import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeTextFieldScreen extends FormeScreen {
  static const String name = 'textField';
  FormeTextFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormeTextField',
            builder: (context, key) {
              return [
                Example(
                  title: 'FormeTextField',
                  buttons: [
                    TextButton(
                      child: const Text('update value'),
                      onPressed: () {
                        key.field(name).value = 'new value';
                      },
                    ),
                    TextButton(
                      child: const Text('select all'),
                      onPressed: () {
                        (key.field(name) as FormeTextFieldController)
                                .textEditingController
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset:
                                    (key.field(name).value as String).length);
                      },
                    )
                  ],
                  field: FormeTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: 'Hello World',
                    name: name,
                    maxLength: 20,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'FormeTextField',
                      prefixIcon: const Icon(Icons.people),
                      suffixIconConstraints: const BoxConstraints.tightFor(),
                      suffixIcon: Builder(builder: (context) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ValueListenableBuilder<FormeFieldValidation>(
                                valueListenable:
                                    key.field(name).validationListenable,
                                builder: (context, validation, child) {
                                  if (validation.isWaiting) {
                                    return const SizedBox();
                                  }
                                  if (validation.isValid) {
                                    return const Icon(
                                      Icons.check_circle,
                                      color: Colors.greenAccent,
                                    );
                                  }

                                  if (validation.isFail) {
                                    return const Icon(
                                      Icons.dangerous,
                                      color: Colors.redAccent,
                                    );
                                  }

                                  if (validation.isInvalid) {
                                    return const Icon(Icons.warning,
                                        color: Colors.redAccent);
                                  }

                                  if (validation.isValidating) {
                                    return const Padding(
                                      padding: EdgeInsets.all(0),
                                      child: SizedBox(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.orangeAccent),
                                        ),
                                        height: 16,
                                        width: 16,
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                }),
                            ValueListenableBuilder2<bool, String>(
                                key.field(name).focusListenable,
                                (key.field(name) as FormeTextFieldController)
                                    .valueListenable,
                                builder: (context, v1, v2, child) {
                              if (v1 && v2.isNotEmpty) {
                                return IconButton(
                                    onPressed: () {
                                      key.field(name).value = '';
                                    },
                                    icon: const Icon(Icons.clear));
                              }
                              return const SizedBox();
                            }),
                          ],
                        );
                      }),
                    ),
                    validator: (f, v) {
                      if (v.isEmpty) {
                        return 'value can not be empty';
                      }
                      return null;
                    },
                    asyncValidator: (f, v, isValid) {
                      return Future.delayed(const Duration(milliseconds: 1500),
                          () {
                        if (v.length < 8) {
                          return 'value is exists';
                        }
                        return null;
                      });
                    },
                  ),
                  formeKey: key,
                  name: name,
                ),
                Example(
                    formeKey: key,
                    name: 'obscureText',
                    title: 'ObscureText',
                    field: FormeTextField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'obscureText',
                        maxLength: 20,
                        autofocus: true,
                        decoration:
                            const InputDecoration(labelText: 'Obscure'))),
                Example(
                    formeKey: key,
                    name: 'textarea',
                    title: 'Textarea',
                    field: FormeTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'textarea',
                        maxLength: 200,
                        maxLines: 10,
                        autofocus: true,
                        decoration: const InputDecoration(
                            labelText: 'Textarea',
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always))),
              ];
            });
}
