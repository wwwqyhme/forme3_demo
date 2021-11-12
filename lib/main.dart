import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/forme_async_input_chip.dart';

import 'cupertino_form.dart';
import 'forme_chip.dart';
import 'forme_cupertino_slider.dart';
import 'forme_cupertino_text_field.dart';
import 'forme_list_tile.dart';
import 'forme_cupertino_date_time_field.dart';
import 'forme_cupertino_number_text_field.dart';
import 'forme_cupertino_picker.dart';
import 'forme_cupertino_segmented_control.dart';
import 'forme_cupertino_switch.dart';
import 'forme_dropdown.dart';
import 'forme_number_field.dart';
import 'forme_switch.dart';
import 'forme_autocomplete.dart';
import 'forme_checkbox.dart';
import 'forme_slider.dart';
import 'forme_text_field.dart';
import 'forme_time.dart';
import 'material_form.dart';

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
        '/MaterialForm': (context) => const MaterialFormScreen(),
        '/CupertinoForm': (context) => const CupertinoFormScreen(),
        '/FormeAsyncInputChip': (context) => FormeAsyncInputChipScreen(),
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
  FormeKey key = FormeKey();
  int index = 0;
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
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          children: const [
            ExpansionTile(
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
            ExpansionTile(
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
            ExpansionTile(
              title: Text(
                "Forme Fields",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: FieldLink('FormeAutocomplete'),
                ),
                ListTile(
                  title: FieldLink('FormeAsyncInputChip'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                "Form",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                ListTile(
                  title: FieldLink('MaterialForm'),
                ),
                ListTile(
                  title: FieldLink('CupertinoForm'),
                ),
              ],
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
