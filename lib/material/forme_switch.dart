import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeSwitchScreen extends FormeScreen {
  FormeSwitchScreen({Key? key})
      : super(
            key: key,
            title: 'FormeSwitch',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  buttons: [
                    TextButton(
                        onPressed: () {
                          key.field('switch').value = true;
                        },
                        child: const Text('on')),
                    TextButton(
                        onPressed: () {
                          key.field('switch').value = false;
                        },
                        child: const Text('off'))
                  ],
                  field: FormeSwitch(
                    autovalidateMode: AutovalidateMode.always,
                    decorator: FormeFieldDecoratorBuilder(
                        buider: (context, child, field) {
                      return Row(
                        children: [
                          child,
                          field.errorText == null
                              ? const SizedBox.shrink()
                              : Text(
                                  field.errorText!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                        ],
                      );
                    }),
                    name: 'switch',
                    validator: (f, v) {
                      if (!v) return 'turn on pls!';
                      return null;
                    },
                  ),
                  title: 'FormeSwitch',
                ),
                Example(
                  formeKey: key,
                  field: FormeSwitchTile(
                    selected: true,
                    tristate: true,
                    title: const Text('Animate Slowly'),
                    secondary: const Icon(Icons.hourglass_empty),
                    name: 'switch2',
                    validator: (f, v) {
                      if (!v) return 'check me pls!';
                      return null;
                    },
                  ),
                  title: 'FormeSwitchTile',
                  subTitle: 'list tile like',
                )
              ];
            });
}
