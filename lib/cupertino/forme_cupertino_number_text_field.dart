import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';

import '../cupertino_exmaple.dart';
import '../forme_screen.dart';

class FormeCupertinoNumberTextFieldScreen extends FormeScreen {
  FormeCupertinoNumberTextFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormeNumberField',
            builder: (context, key) {
              return [
                CupertinoExample(
                  formeKey: key,
                  name: 'number',
                  field: FormeCupertinoNumberField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'number',
                    max: 100,
                    validator: FormeValidates.max(100,
                        errorText: 'value can  not bigger than 100'),
                  ),
                  buttons: [
                    CupertinoButton(
                        onPressed: () {
                          key.field('number').value = 9999;
                        },
                        child: const Text('set value to 1000'))
                  ],
                  title: 'FormeCupertinoNumberField',
                ),
                CupertinoExample(
                  subTitle: 'allow decimal',
                  formeKey: key,
                  name: 'number2',
                  field: FormeCupertinoNumberField(
                    decimal: 2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'number2',
                    max: 100,
                  ),
                  title: 'FormeCupertinoNumberField2',
                ),
                CupertinoExample(
                  subTitle: 'allow negative',
                  formeKey: key,
                  name: 'number3',
                  field: FormeCupertinoNumberField(
                    decimal: 2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'number3',
                    max: 100,
                    allowNegative: true,
                  ),
                  title: 'FormeCupertinoNumberField3',
                )
              ];
            });
}
