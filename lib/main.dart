import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:fluent_ui/l10n/generated/fluent_localizations.dart';
import 'package:flutter/material.dart';
import 'package:forme_demo/fluent/forme_checkbox.dart';
import 'package:forme_demo/fluent/forme_combobox.dart';
import 'package:forme_demo/fluent/forme_fluent_datepicker.dart';
import 'package:forme_demo/fluent/forme_rating_bar.dart';
import 'package:forme_demo/fluent/forme_slider.dart';
import 'package:forme_demo/fluent/forme_textbox.dart';
import 'cupertino/forme_datetime.dart';
import 'cupertino/forme_number.dart';
import 'cupertino/forme_picker.dart';
import 'cupertino/forme_segmented_control.dart';
import 'cupertino/forme_slider.dart';
import 'cupertino/forme_switch.dart';
import 'cupertino/forme_textfield.dart';
import 'fluent/forme_toggle_switch.dart';
import 'material/signup.dart';
import 'material/forme_checkbox.dart';
import 'material/forme_chip.dart';
import 'material/forme_dropdown.dart';
import 'material/forme_list_tile.dart';
import 'material/forme_number_field.dart';
import 'material/forme_slider.dart';
import 'material/forme_switch.dart';
import 'material/forme_time.dart';
import 'other/forme_async_input_chip.dart';
import 'other/forme_autocomplete.dart';
import 'other/forme_file_grid.dart';
import 'other/forme_pin_code.dart';
import 'other/forme_rating_bar.dart';
import 'other/forme_spin_number.dart';
import 'package:url_launcher/url_launcher.dart';

import 'material/forme_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forme Demo',
      localizationsDelegates: FluentLocalizations.localizationsDelegates,
      supportedLocales: FluentLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blueAccent),
        ),
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Forme Demo'),
        '/FormeTextField': (context) => FormeTextFieldScreen(),
        '/FormeCheckbox': (context) => FormeCheckboxScreen(),
        '/FormeSwitch': (context) => FormeSwitchScreen(),
        '/FormeDropdown': (context) => FormeDropdownScreen(),
        '/FormeTimeField': (context) => FormeTimeFieldScreen(),
        '/FormeNumberField': (context) => FormeNumberFieldScreen(),
        '/FormeSlider': (context) => FormeSliderScreen(),
        '/FormeChip': (context) => FormeChipScreen(),
        '/FormeListTile': (context) => FormeListTileScreen(),
        '/FormeCupertinoTextField': (context) =>
            FormeCupertinoTextFieldScreen(),
        '/FormeCupertinoDateTimeField': (context) =>
            FormeCupertinoDateTimeFieldScreen(),
        '/FormeCupertinoNumberTextField': (context) =>
            FormeCupertinoNumberTextFieldScreen(),
        '/FormeCupertinoSegmentedControl': (context) =>
            FormeCupertinoSegmentedControlScreen(),
        '/FormeCupertinoSlider': (context) => FormeCupertinoSliderScreen(),
        '/FormeCupertinoSwitch': (context) => FormeCupertinoSwitchScreen(),
        '/FormeCupertinoPicker': (context) => FormeCupertinoPickerScreen(),
        '/FormeRatingBar': (context) => FormeRatingBarScreen(),
        '/FormeSpinNumberField': (context) => FormeSpinNumberFieldScreen(),
        '/FormePinCodeTextField': (context) => FormePinCodeTextFieldScreen(),
        '/FormeFileGrid': (context) => FormeFileGridScreen(),
        '/FormeAutocomplete': (context) => FormeAutocompleteScreen(),
        '/FormeAsyncInputChip': (context) => FormeAsyncInputChipScreen(),
        '/FormeFluentCheckbox': (context) => FormeFluentCheckBoxScreen(),
        '/FormeFluentToggleSwitch': (context) =>
            FormeFluentToggleSwitchScreen(),
        '/FormeFluentSlider': (context) => FormeFluentSliderScreen(),
        '/FormeFluentRatingBar': (context) => FormeFluentRatingBarScreen(),
        '/FormeFluentCombobox': (context) => FormeFluentComboboxScreen(),
        '/FormeFluentDatePicker': (context) => FormeFluentDateScreen(),
        '/FormeFluentTextBox': (context) => FormeFluentTextBoxScreen(),
        '/Signup': (context) => const Signup(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExpansionTile(
              title: Text(
                "Material Fields",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: FieldLink('FormeTextField'),
                ),
                ListTile(
                  title: FieldLink('FormeCheckbox'),
                ),
                ListTile(
                  title: FieldLink('FormeSwitch'),
                ),
                ListTile(
                  title: FieldLink('FormeDropdown'),
                ),
                ListTile(
                  title: FieldLink('FormeTimeField'),
                ),
                ListTile(
                  title: FieldLink('FormeNumberField'),
                ),
                ListTile(
                  title: FieldLink('FormeSlider'),
                ),
                ListTile(
                  title: FieldLink('FormeChip'),
                ),
                ListTile(
                  title: FieldLink('FormeListTile'),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "Cupertino Fields",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: FieldLink('FormeCupertinoTextField'),
                ),
                ListTile(
                  title: FieldLink('FormeCupertinoDateTimeField'),
                ),
                ListTile(
                  title: FieldLink('FormeCupertinoNumberTextField'),
                ),
                ListTile(
                  title: FieldLink('FormeCupertinoSegmentedControl'),
                ),
                ListTile(
                  title: FieldLink('FormeCupertinoSlider'),
                ),
                ListTile(
                  title: FieldLink('FormeCupertinoSwitch'),
                ),
                ListTile(
                  title: FieldLink('FormeCupertinoPicker'),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "Fluent Fields",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: FieldLink('FormeFluentCheckbox'),
                ),
                ListTile(
                  title: FieldLink('FormeFluentToggleSwitch'),
                ),
                ListTile(
                  title: FieldLink('FormeFluentSlider'),
                ),
                ListTile(
                  title: FieldLink('FormeFluentRatingBar'),
                ),
                ListTile(
                  title: FieldLink('FormeFluentCombobox'),
                ),
                ListTile(
                  title: FieldLink('FormeFluentDatePicker'),
                ),
                ListTile(
                  title: FieldLink('FormeFluentTextBox'),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text(
                "Other Fields",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: FieldLink('FormeRatingBar'),
                ),
                ListTile(
                  title: FieldLink('FormeSpinNumberField'),
                ),
                ListTile(
                  title: FieldLink('FormePinCodeTextField'),
                ),
                ListTile(
                  title: FieldLink('FormeFileGrid'),
                ),
                ListTile(
                  title: FieldLink('FormeAutocomplete'),
                ),
                ListTile(
                  title: FieldLink('FormeAsyncInputChip'),
                ),
              ],
            ),
            const ListTile(
              title: FieldLink('Signup'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                  child: const Text("https://github.com/wwwqyhme/forme3_demo",
                      style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onTap: () => launchUrl(
                      Uri.parse('https://github.com/wwwqyhme/forme3_demo'))),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FieldLink extends StatelessWidget {
  final String field;

  const FieldLink(this.field, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/' + field);
        },
        child: Text(field),
      ),
    );
  }
}
