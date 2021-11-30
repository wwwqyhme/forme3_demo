import 'package:flutter/material.dart';
import 'package:forme_demo/example/dynamic_fields.dart';
import 'package:forme_demo/extra/forme_pin_code_text_field.dart';
import 'package:forme_demo/extra/forme_spin_number_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'example/associate_validation.dart';
import 'extra/forme_rating_bar.dart';
import 'example/cupertino_form.dart';
import 'extra/forme_async_input_chip.dart';
import 'material/forme_chip.dart';
import 'cupertino/forme_cupertino_slider.dart';
import 'cupertino/forme_cupertino_text_field.dart';
import 'material/forme_list_tile.dart';
import 'cupertino/forme_cupertino_date_time_field.dart';
import 'cupertino/forme_cupertino_number_text_field.dart';
import 'cupertino/forme_cupertino_picker.dart';
import 'cupertino/forme_cupertino_segmented_control.dart';
import 'cupertino/forme_cupertino_switch.dart';
import 'material/forme_dropdown.dart';
import 'material/forme_number_field.dart';
import 'material/forme_switch.dart';
import 'extra/forme_autocomplete.dart';
import 'material/forme_checkbox.dart';
import 'material/forme_slider.dart';
import 'material/forme_text_field.dart';
import 'material/forme_time.dart';
import 'example/profile.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blueAccent),
        ),
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Forme Demo'),
        '/FormeTextField': (context) => FormeTextFieldScreen(),
        '/FormeCheckbox': (context) => FormeCheckboxScreen(),
        '/FormeAutocomplete': (context) => FormeAutocompleteScreen(),
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
        '/Profile': (context) => const ProfileScreen(),
        '/CupertinoForm': (context) => const CupertinoFormScreen(),
        '/FormeAsyncInputChip': (context) => FormeAsyncInputChipScreen(),
        '/FormeRatingBar': (context) => FormeRatingBarScreen(),
        '/FormePinCodeTextField': (context) => FormePinCodeTextFieldScreen(),
        '/FormeSpinNumberField': (context) => FormeSpinNumberFieldScreen(),
        '/AssociateValidation': (context) => const AssociateValidationScreen(),
        '/DynamicFields': (context) => const DynamicFieldsScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          children: [
            const ExpansionTile(
              title: Text(
                "Material Field",
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
                "Cupertino Field",
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
                "Extra Fields",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: FieldLink('FormeAutocomplete'),
                ),
                ListTile(
                  title: FieldLink('FormeAsyncInputChip'),
                ),
                ListTile(
                  title: FieldLink('FormeRatingBar'),
                ),
                ListTile(
                  title: FieldLink('FormePinCodeTextField'),
                ),
                ListTile(
                  title: FieldLink('FormeSpinNumberField'),
                )
              ],
            ),
            const ExpansionTile(
              title: Text(
                "Example",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: FieldLink('Profile'),
                ),
                ListTile(
                  title: FieldLink('AssociateValidation'),
                ),
                ListTile(
                  title: FieldLink('DynamicFields'),
                ),
                ListTile(
                  title: FieldLink('CupertinoForm'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                  child: const Text("https://github.com/wwwqyhme/forme3_demo",
                      style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onTap: () =>
                      launch('https://github.com/wwwqyhme/forme3_demo')),
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
