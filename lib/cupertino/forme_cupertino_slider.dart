import 'package:flutter/cupertino.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import 'package:forme_demo/forme_screen.dart';

import '../cupertino_exmaple.dart';
import '../forme_screen.dart';

class FormeCupertinoSliderScreen extends FormeScreen {
  FormeCupertinoSliderScreen({Key? key})
      : super(
            title: 'FormeCupertinoSlider',
            key: key,
            builder: (context, key) {
              return [
                CupertinoExample(
                  formeKey: key,
                  name: 'slider',
                  title: 'FormeCupertinoSlider',
                  field: FormeCupertinoSlider(
                    name: 'slider',
                    min: 1,
                    max: 100,
                    decorator: FormeCupertinoSliderFullWidthDecorator(),
                  ),
                ),
              ];
            });
}
