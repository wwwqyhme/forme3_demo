import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';

import 'forme_screen.dart';
import 'exmaple.dart';

class FormeCheckboxScreen extends FormeScreen {
  FormeCheckboxScreen({Key? key})
      : super(
            key: key,
            title: 'FormeCheckbox',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'checkbox',
                  buttons: [
                    TextButton(
                        onPressed: () {
                          key.field('checkbox').value = true;
                        },
                        child: const Text('check')),
                    TextButton(
                        onPressed: () {
                          key.field('checkbox').value = false;
                        },
                        child: const Text('uncheck'))
                  ],
                  field: FormeCheckbox(
                    name: 'checkbox',
                    validator: (f, v) {
                      if (!v!) return 'check me pls!';
                      return null;
                    },
                  ),
                  title: 'FormeCheckbox',
                ),
                Example(
                  formeKey: key,
                  name: 'checkbox2',
                  field: FormeCheckbox(
                    tristate: true,
                    name: 'checkbox2',
                    validator: (f, v) {
                      if (!v!) return 'check me pls!';
                      return null;
                    },
                  ),
                  title: 'FormeCheckbox2',
                  subTitle: 'nullable',
                )
              ];
            });
}
