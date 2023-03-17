import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../cupertino_example.dart';
import '../forme_screen.dart';

class FormeCupertinoTextFieldScreen extends FormeScreen {
  FormeCupertinoTextFieldScreen({Key? key})
      : super(
            title: 'FormeCupertinoTextField',
            key: key,
            builder: (context, key) {
              return [
                CupertinoExample(
                    formeKey: key,
                    name: 'text-field',
                    title: 'FormeCupertinoTextField',
                    field: FormeCupertinoTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'text-field',
                      suffix: Builder(builder: (context) {
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
                                  if (validation.isWaiting ||
                                      validation.isUnnecessary) {
                                    return const SizedBox();
                                  }
                                  if (validation.isValid) {
                                    return const Icon(
                                      CupertinoIcons.check_mark_circled,
                                      color: CupertinoColors.systemGreen,
                                    );
                                  }

                                  if (validation.isFail) {
                                    return const Icon(
                                      CupertinoIcons.clear_thick_circled,
                                      color: CupertinoColors.systemRed,
                                    );
                                  }

                                  if (validation.isInvalid) {
                                    return const Icon(
                                      CupertinoIcons.clear_thick_circled,
                                      color: CupertinoColors.systemOrange,
                                    );
                                  }

                                  if (validation.isValidating) {
                                    return const CupertinoActivityIndicator();
                                  }

                                  return const SizedBox();
                                }),
                          ],
                        );
                      }),
                      validator: (f, v) {
                        if (v.isEmpty) {
                          return 'value can not be empty';
                        }
                        return null;
                      },
                      asyncValidator: (f, v, isValid) {
                        return Future.delayed(
                            const Duration(milliseconds: 1500), () {
                          if (v.length < 8) {
                            return 'value is exists';
                          }
                          return null;
                        });
                      },
                    )),
                CupertinoExample(
                    formeKey: key,
                    name: 'obscureText',
                    title: 'ObscureText',
                    field: FormeCupertinoTextField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'obscureText',
                      maxLength: 20,
                    )),
              ];
            });
}
