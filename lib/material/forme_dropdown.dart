import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeDropdownScreen extends FormeScreen {
  FormeDropdownScreen({Key? key})
      : super(
            key: key,
            title: 'FormeDropdown',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'dropdown',
                  field: FormeDropdownButton<String>(
                    // useTempValueDuringBeforeValueChangedChecking: false,
                    beforeValueChanged: (f, v, isValid) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return v == 'item3';
                      });
                    },
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
                )
              ];
            });
}
