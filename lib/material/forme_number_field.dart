import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeNumberFieldScreen extends FormeScreen {
  FormeNumberFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormeNumberField',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'number',
                  field: FormeNumberField(
                    decoration: const InputDecoration(labelText: 'Number'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'number',
                    max: 100,
                    validator: FormeValidates.max(100,
                        errorText: 'value can  not bigger than 100'),
                  ),
                  buttons: [
                    TextButton(
                        onPressed: () {
                          key.field('number').value = 9999;
                        },
                        child: const Text('set value to 1000'))
                  ],
                  title: 'FormeNumberField',
                ),
                Example(
                  subTitle: 'allow decimal',
                  formeKey: key,
                  name: 'number2',
                  field: FormeNumberField(
                    decoration: const InputDecoration(labelText: 'Number'),
                    decimal: 2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'number2',
                    max: 100,
                  ),
                  title: 'FormeNumberField2',
                ),
                Example(
                  subTitle: 'allow negative',
                  formeKey: key,
                  name: 'number3',
                  field: FormeNumberField(
                    decoration: const InputDecoration(labelText: 'Number'),
                    decimal: 2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'number3',
                    max: 100,
                    allowNegative: true,
                  ),
                  title: 'FormeNumberField3',
                )
              ];
            });
}
