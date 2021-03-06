import 'package:flutter/cupertino.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import '../cupertino_example.dart';
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
