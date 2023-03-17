import 'package:flutter/cupertino.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import '../cupertino_example.dart';
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
                  field: Row(children: [
                    Expanded(
                        child: FormeCupertinoSlider(
                      name: 'slider',
                      min: 1,
                      max: 100,
                    ))
                  ]),
                ),
              ];
            });
}
