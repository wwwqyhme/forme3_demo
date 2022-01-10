import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

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
                      if (v == null) {
                        return null;
                      }
                      if (!v) return 'check me pls!';
                      return null;
                    },
                  ),
                  title: 'FormeCheckbox2',
                  subTitle: 'nullable',
                ),
                Example(
                  formeKey: key,
                  name: 'checkbox3',
                  field: FormeCheckboxTile(
                    selected: true,
                    tristate: true,
                    title: const Text('Animate Slowly'),
                    secondary: const Icon(Icons.hourglass_empty),
                    name: 'checkbox3',
                    validator: (f, v) {
                      if (v == null) {
                        return null;
                      }
                      if (!v) return 'check me pls!';
                      return null;
                    },
                  ),
                  title: 'FormeCheckboxTile',
                  subTitle: 'list tile like',
                )
              ];
            });
}
