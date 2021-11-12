import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/forme_screen.dart';

import '../cupertino_exmaple.dart';
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
                    field: FormeCupertinoDateTimeField(
                      name: 'date',
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('Date'),
                        ),
                      ),
                    )),
                CupertinoExample(
                    formeKey: key,
                    name: 'date-time',
                    title: 'FormeCupertinoDateTimeField2',
                    field: FormeCupertinoDateTimeField(
                      type: FormeDateTimeType.dateTime,
                      name: 'date-time',
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('Date&Time'),
                        ),
                      ),
                    )),
                CupertinoExample(
                    formeKey: key,
                    name: 'duration',
                    title: 'FormeCupertinoTimerField',
                    field: FormeCupertinoTimerField(
                      name: 'duration',
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('Duration'),
                        ),
                      ),
                    )),
              ];
            });
}
