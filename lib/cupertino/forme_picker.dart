import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import '../cupertino_example.dart';
import '../forme_screen.dart';

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
                  field: Column(children: [
                    FormeCupertinoPicker(
                      itemExtent: 30,
                      children: List.generate(100, (index) => '$index')
                          .map((e) => Text('item$e'))
                          .toList(),
                      name: 'picker',
                      triggerBuilder: (state) {
                        return CupertinoButton(
                            child: const Text('select'),
                            onPressed: state.showPicker);
                      },
                    ),
                    FormeFieldStatusListener(
                        name: 'picker',
                        filter: (status) => status.isValueChanged,
                        builder: (context, status, child) {
                          if (status == null) {
                            return const SizedBox.shrink();
                          }
                          return Text('${status.value ?? ''}');
                        }),
                  ]),
                ),
              ];
            });
}
