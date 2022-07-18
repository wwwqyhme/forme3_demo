import 'package:flutter/material.dart';
import 'package:forme_demo/material/forme_expansion_list_tile.dart';
import 'cupertino/forme_datetime.dart';
import 'cupertino/forme_number.dart';
import 'cupertino/forme_picker.dart';
import 'cupertino/forme_segmented_control.dart';
import 'cupertino/forme_slider.dart';
import 'cupertino/forme_switch.dart';
import 'cupertino/forme_textfield.dart';
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
        '/FormeExpansionListTile': (context) => FormeExpansionListTileScreen(),
        '/Signup': (context) => const Signup(),
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

  List<Widget> children = [];

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
                ListTile(
                  title: FieldLink('FormeExpansionListTile'),
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
