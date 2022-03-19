import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeDropdownScreen extends FormeScreen {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  FormeDropdownScreen({Key? key})
      : super(
            key: key,
            title: 'FormeDropdown',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  field: FormeDropdownButton<String>(
                    icon: Row(children: [
                      InkWell(
                        onTap: () {
                          key.field('dropdown').value = null;
                        },
                        child: const Icon(Icons.clear),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ], mainAxisSize: MainAxisSize.min),
                    name: 'dropdown',
                    decoration:
                        const InputDecoration(labelText: 'FormeDropdownButton'),
                    items: const [
                      DropdownMenuItem(child: Text('item1'), value: 'item1'),
                      DropdownMenuItem(child: Text('item2'), value: 'item2'),
                      DropdownMenuItem(child: Text('item3'), value: 'item3'),
                      DropdownMenuItem(child: Text('item4'), value: 'item4'),
                    ],
                  ),
                  title: 'FormeDropdown',
                ),
                Example(
                  formeKey: key,
                  subTitle: 'select item3 only',
                  field: FormeDropdownButton<String>(
                    beforeValueChanged: (field, value, isValid) async {
                      if (isValid()) {
                        return value == 'item3';
                      }
                      return true;
                    },
                    icon: Row(children: [
                      InkWell(
                        onTap: () {
                          key.field('dropdown2').value = null;
                        },
                        child: const Icon(Icons.clear),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ], mainAxisSize: MainAxisSize.min),
                    name: 'dropdown2',
                    decoration:
                        const InputDecoration(labelText: 'FormeDropdownButton'),
                    items: const [
                      DropdownMenuItem(child: Text('item1'), value: 'item1'),
                      DropdownMenuItem(child: Text('item2'), value: 'item2'),
                      DropdownMenuItem(child: Text('item3'), value: 'item3'),
                      DropdownMenuItem(child: Text('item4'), value: 'item4'),
                    ],
                  ),
                  title: 'FormeDropdown2',
                ),
                Example(
                  formeKey: key,
                  subTitle: 'update dropdown menu items',
                  buttons: [
                    TextButton(
                        onPressed: () {
                          /// if FormeDropdownButton.valueUpdater is null , an error will be occured
                          (context as Element).markNeedsBuild();
                        },
                        child: const Text('update children'))
                  ],
                  field: FormeDropdownButton<String>(
                    valueUpdater: (oldWidget, widget, oldValue) {
                      FormeDropdownButton<String> w =
                          widget as FormeDropdownButton<String>;
                      return w.items.first.value;
                    },
                    icon: Row(children: [
                      InkWell(
                        onTap: () {
                          key.field('dropdown3').value = null;
                        },
                        child: const Icon(Icons.clear),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ], mainAxisSize: MainAxisSize.min),
                    name: 'dropdown3',
                    decoration:
                        const InputDecoration(labelText: 'FormeDropdownButton'),
                    items: [
                      DropdownMenuItem(
                          child: Text(getRandomString(5)),
                          value: getRandomString(5)),
                      DropdownMenuItem(
                          child: Text(getRandomString(6)),
                          value: getRandomString(6)),
                      DropdownMenuItem(
                          child: Text(getRandomString(7)),
                          value: getRandomString(7)),
                    ],
                  ),
                  title: 'FormeDropdown3',
                )
              ];
            });
}
