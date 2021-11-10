import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/forme_screen.dart';

import 'cupertino_exmaple.dart';

class FormeCupertinoPickerScreen extends FormeScreen {
  FormeCupertinoPickerScreen({Key? key})
      : super(
            title: 'FormeCupertinoPicker',
            key: key,
            builder: (context, key) {
              return [
                CupertinoExample(
                  formeKey: key,
                  name: 'picker',
                  title: 'FormeCupertinoPicker',
                  field: FormeCupertinoPicker(
                    itemExtent: 30,
                    children: List.generate(100, (index) => '$index')
                        .map((e) => Text('item$e'))
                        .toList(),
                    name: 'picker',
                  ),
                ),
              ];
            });
}
