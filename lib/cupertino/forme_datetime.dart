import 'package:flutter/cupertino.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../cupertino_example.dart';
import '../forme_screen.dart';

class FormeCupertinoDateTimeFieldScreen extends FormeScreen {
  FormeCupertinoDateTimeFieldScreen({Key? key})
      : super(
            title: 'FormeCupertinoDateTimeField',
            key: key,
            builder: (context, key) {
              return [
                CupertinoExample(
                    formeKey: key,
                    name: 'date',
                    title: 'FormeCupertinoDateTimeField',
                    field: FormeCupertinoDateField(
                      name: 'date',
                      triggerBuilder: (state) {
                        return CupertinoButton(
                            child: const Text('select'),
                            onPressed: state.showPicker);
                      },
                    )),
                CupertinoExample(
                    formeKey: key,
                    name: 'date-time',
                    title: 'FormeCupertinoDateTimeField2',
                    field: FormeCupertinoDateField(
                      type: FormeDateTimeType.dateTime,
                      name: 'date-time',
                      triggerBuilder: (state) {
                        return CupertinoButton(
                            child: const Text('select'),
                            onPressed: state.showPicker);
                      },
                    )),
                CupertinoExample(
                    formeKey: key,
                    name: 'duration',
                    title: 'FormeCupertinoTimerField',
                    field: FormeCupertinoTimerField(
                      name: 'duration',
                      triggerBuilder: (state) {
                        return CupertinoButton(
                            child: const Text('select'),
                            onPressed: state.showPicker);
                      },
                    )),
              ];
            });
}
