import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
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
                        (key.field(name) as FormeTextFieldState)
                                .textEditingController
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset:
                                    (key.field(name).value as String).length);
                        key.field(name).focusNode.requestFocus();
                      },
                    ),
                    TextButton(
                      child: const Text('custom error text'),
                      onPressed: () {
                        key.field(name).errorText = 'custom error text';
                      },
                    ),
                  ],
                  field: FormeTextField(
                    // selectAllOnFocus: true,
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
                            FormeFieldStatusListener<String>(
                                filter: (status) => status.isValidationChanged,
                                builder: (context, status, child) {
                                  if (status == null) {
                                    return const SizedBox.shrink();
                                  }
                                  FormeFieldValidation validation =
                                      status.validation;
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
                            FormeFieldStatusListener<String>(
                                filter: (status) =>
                                    status.isFocusChanged ||
                                    status.isValueChanged,
                                builder: (context, status, child) {
                                  if (status == null) {
                                    return const SizedBox.shrink();
                                  }
                                  final bool hasFocus = status.hasFocus;
                                  final String value = status.value;

                                  if (hasFocus && value.isNotEmpty) {
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
                ),
                Example(
                    formeKey: key,
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
