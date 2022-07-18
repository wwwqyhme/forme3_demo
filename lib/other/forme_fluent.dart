import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_fluent/forme_fluent.dart';

class FormeFluent extends StatelessWidget {
  const FormeFluent({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            accentColor: Colors.blue,
            iconTheme: const IconThemeData(size: 24)),
        darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            accentColor: Colors.blue,
            iconTheme: const IconThemeData(size: 24)),
        home: const FormeFluentPage());
  }
}

class FormeFluentPage extends StatefulWidget {
  const FormeFluentPage({Key? key}) : super(key: key);

  @override
  State<FormeFluentPage> createState() => _State();
}

class _State extends State<FormeFluentPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Forme(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormeFluentCheckbox(
              decorator:
                  const FormeFluentInputDecoratorBuilder(label: 'checkbox'),
              initialValue: false,
              name: 'checkbox',
              content: FormeFieldStatusListener<bool?>(
                filter: (status) => status.isValueChanged,
                builder: (context, status, child) {
                  if (status != null) {
                    bool? checked = status.value;
                    return Text(
                      checked == null
                          ? 'unknow'
                          : checked
                              ? 'checked'
                              : 'unchecked',
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            FormeFluentToggleSwitch(
              name: 'switch',
              decorator:
                  const FormeFluentInputDecoratorBuilder(label: 'Switch'),
              content: FormeFieldStatusListener<bool>(
                builder: (context, status, child) {
                  if (status != null) {
                    return Text(status.value ? 'on' : 'off');
                  }
                  return const SizedBox();
                },
              ),
            ),
            FormeFluentTextBox(
              name: 'textBox',
              header: 'TextBox',
              suffix: Builder(builder: (context) {
                return FormeFieldStatusListener<String>(
                    filter: (status) =>
                        status.isValueChanged || status.isValidationChanged,
                    builder: (context, status, child) {
                      if (status == null) {
                        return const SizedBox.shrink();
                      }
                      final List<Widget> children = [];
                      if (status.value.isNotEmpty) {
                        children.add(
                          IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: () {
                              FormeField.of(context)!.value = '';
                            },
                          ),
                        );
                      }
                      if (status.validation ==
                          FormeFieldValidation.validating) {
                        children.add(const SizedBox(
                          width: 12,
                          height: 12,
                          child: ProgressRing(),
                        ));
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      );
                    });
              }),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              asyncValidator: (f, v, valid) {
                return Future.delayed(const Duration(seconds: 1), () {
                  return 'error input';
                });
              },
              placeholder: 'Type your notes here',
              decorator: const FormeFluentInputDecoratorBuilder<String>(),
            ),
            FormeFluentSlider(
              decorator:
                  const FormeFluentInputDecoratorBuilder(label: 'Slider'),
              requestFocusOnUserInteraction: false,
              name: 'slider',
              min: 0,
              max: 100,
            ),
            FormeFluentRatingBar(
              decorator:
                  const FormeFluentInputDecoratorBuilder(label: 'Rating Bar'),
              requestFocusOnUserInteraction: false,
              name: 'rating',
              ratedIconColor: Colors.red,
              unratedIconColor: Colors.yellow,
              amount: 10,
            ),
            FormeFluentCombobox<String>(
              name: 'combobox',
              decorator: FormeFluentInputDecoratorBuilder(
                label: 'Combobox',
                wrapper: (child) {
                  return SizedBox(height: 41, child: child);
                },
              ),
              placeholder: const Text('Selected list item'),
              items: ['Blue', 'Green', 'Yellow', 'Red']
                  .map((e) => ComboboxItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
            FormeFluentDatePicker(
              name: 'date',
              header: 'Date Picker',
              initialValue: DateTime.now(),
              decorator: const FormeFluentInputDecoratorBuilder(),
            ),
            FormeFluentTimePicker(
              name: 'time',
              header: 'Time Picker',
              initialValue: FluentTimeOfDay.fromDateTime(DateTime.now()),
              decorator: const FormeFluentInputDecoratorBuilder(),
            ),
            FormeFluentAutoSuggestBox(
              decorator:
                  const FormeFluentInputDecoratorBuilder(label: 'Auto Suggest'),
              name: 'autoSuggest',
              items: const [
                'Blue',
                'Green',
                'Red',
                'Yellow',
                'Grey',
              ],
            )
          ],
        )),
      ),
    );
  }
}
