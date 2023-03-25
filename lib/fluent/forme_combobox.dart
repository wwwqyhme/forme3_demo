import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import '../forme_screen.dart';

class FormeFluentComboboxScreen extends FormeScreen {
  FormeFluentComboboxScreen({Key? key})
      : super(
            title: 'FormeFluentCombobox',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'combobox',
                  title: '',
                  field: Column(children: [
                    FormeFluentComboBox<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decorator: const FormeFluentFormRowDecorator.noPadding(),
                      validator: FormeValidates.equals('6', errorText: '6'),
                      initialValue: '5',
                      isExpanded: true,
                      name: 'combobox',
                      items: '123456789'
                          .characters
                          .map((e) => ComboBoxItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                    )
                  ]),
                ),
              ];
            });
}
