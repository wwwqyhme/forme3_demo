import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import 'forme_fluent_screen.dart';

class FormeFluentDateScreen extends FormeFluentScreen {
  FormeFluentDateScreen({Key? key})
      : super(
            title: 'FormeFluentDate',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'date',
                  title: 'Date',
                  field: FormeFluentDatePicker(
                    name: 'date',
                  ),
                ),
                FluentExample(
                    formeKey: key,
                    name: 'time',
                    title: 'Time',
                    field: FormeFluentTimePicker(
                      decorator: const FormeFluentFormRowDecorator.noPadding(),
                      name: 'time',
                    )),
              ];
            });
}
