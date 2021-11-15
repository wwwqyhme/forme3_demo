import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';

import '../exmaple.dart';
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
                  name: 'switch',
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
                  name: 'switch2',
                  field: FormeSwitchTile(
                    selected: true,
                    tristate: true,
                    title: const Text('Animate Slowly'),
                    secondary: const Icon(Icons.hourglass_empty),
                    name: 'switch2',
                    validator: (f, v) {
                      if (!v!) return 'check me pls!';
                      return null;
                    },
                  ),
                  title: 'FormeSwitchTile',
                  subTitle: 'list tile like',
                )
              ];
            });
}
