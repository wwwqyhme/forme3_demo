import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/forme_screen.dart';

import '../cupertino_exmaple.dart';
import '../forme_screen.dart';

class FormeCupertinoSwitchScreen extends FormeScreen {
  FormeCupertinoSwitchScreen({Key? key})
      : super(
            title: 'FormeCupertinoSwitch',
            key: key,
            builder: (context, key) {
              return [
                CupertinoExample(
                  formeKey: key,
                  name: 'switch',
                  title: 'FormeCupertinoSwitch',
                  field: FormeCupertinoSwitch(
                    name: 'switch',
                  ),
                ),
              ];
            });
}
