import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/forme_screen.dart';

import '../cupertino_exmaple.dart';
import '../forme_screen.dart';

class FormeCupertinoSegmentedControlScreen extends FormeScreen {
  FormeCupertinoSegmentedControlScreen({Key? key})
      : super(
            title: 'FormeCupertinoSegmentedControl',
            key: key,
            builder: (context, key) {
              return [
                CupertinoExample(
                  formeKey: key,
                  name: 'segmentedControl',
                  title: 'FormeCupertinoSegmentedControl',
                  field: FormeCupertinoSegmentedControl<String>(
                    name: 'segmentedControl',
                    children: const {
                      'item1': Text('item1'),
                      'item2': Text('item2'),
                      'item3': Text('item3'),
                      'item4': Text('item4'),
                    },
                  ),
                ),
                CupertinoExample(
                  formeKey: key,
                  name: 'slidingSegmentedControl',
                  title: 'FormeCupertinoSlidingSegmentedControl',
                  field: FormeCupertinoSlidingSegmentedControl<String>(
                    name: 'slidingSegmentedControl',
                    children: const {
                      'item1': Text('item1'),
                      'item2': Text('item2'),
                      'item3': Text('item3'),
                      'item4': Text('item4'),
                    },
                  ),
                ),
              ];
            });
}
