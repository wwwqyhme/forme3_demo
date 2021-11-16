import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

class MaterialFormScreen extends StatefulWidget {
  const MaterialFormScreen({Key? key}) : super(key: key);
  @override
  State<MaterialFormScreen> createState() => _MaterialFormScreenState();
}

class _MaterialFormScreenState extends State<MaterialFormScreen> {
  final FormeKey key = FormeKey();

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
        title: const Text('MaterialForm'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Forme(
                key: key,
                child: Column(
                  children: [
                    FormeTextField(
                      name: 'username',
                      decoration: const InputDecoration(labelText: 'username'),
                      onInitialed: (field) {
                        final TextEditingController controller =
                            (field as FormeTextFieldController)
                                .textEditingController;
                        controller.value = const TextEditingValue(
                            text: '123',
                            selection:
                                TextSelection(baseOffset: 0, extentOffset: 1));
                      },
                    ),
                    FormeNumberField(
                      name: 'age',
                      max: 9999,
                      decimal: 2,
                      decoration: const InputDecoration(labelText: 'age'),
                    ),
                    FormeDateTimeField(
                      name: 'birthday',
                      type: FormeDateTimeType.dateTime,
                      decoration: InputDecoration(
                          labelText: 'birthday',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              key.field('birthday').value = null;
                            },
                          )),
                    ),
                    FormeTimeField(
                        name: 'time',
                        decoration: const InputDecoration(
                          labelText: 'time',
                        )),
                    FormeDateTimeRangeField(
                      name: 'range',
                      decoration:
                          const InputDecoration(labelText: 'date range'),
                      validator: (field, v) => '123',
                    ),
                    Row(
                      children: [
                        FormeSwitch(
                          name: 'switch',
                          initialValue: true,
                        ),
                        FormeCheckbox(
                          tristate: true,
                          name: 'checkbox',
                        )
                      ],
                    ),
                    FormeRadioGroup<String>(
                      name: 'radioGroup',
                      decoration: const InputDecoration(
                        labelText: 'radioGroup',
                      ),
                      items: [
                        FormeListTileItem(
                            data: 'first', title: const Text('first')),
                        FormeListTileItem(
                            data: 'second', title: const Text('second')),
                      ],
                    ),
                    FormeListTile<String>(
                      name: 'listTile',
                      decoration: const InputDecoration(
                        labelText: 'radioGroup',
                      ),
                      items: [
                        FormeListTileItem(
                            data: 'first', title: const Text('first')),
                        FormeListTileItem(
                            data: 'second', title: const Text('second')),
                      ],
                    ),
                    FormeChoiceChip<String>(
                      name: 'choiceChip',
                      items: [
                        FormeChipItem(
                            label: const Text('first'), data: 'first'),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'choiceChip',
                      ),
                    ),
                    FormeFilterChip<String>(
                      name: 'filterChip',
                      items: [
                        FormeChipItem(
                            label: const Text('first'), data: 'first'),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'filterChip',
                      ),
                    ),
                    FormeSlider(
                      name: 'slider',
                      min: 1,
                      max: 100,
                      decoration: const InputDecoration(
                        labelText: 'slider',
                      ),
                    ),
                    FormeRangeSlider(
                      name: 'slider',
                      min: 1,
                      max: 100,
                      decoration: const InputDecoration(
                        labelText: 'range slider',
                      ),
                    ),
                    FormeDropdownButton<String>(
                      decoration: const InputDecoration(
                        labelText: 'Dropdown',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onValidationChanged: (field, e) {},
                      asyncValidator: (field, v, isValid) {
                        return Future.delayed(const Duration(milliseconds: 500),
                            () {
                          return 'async validate fail';
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '123',
                          child: Text('xxx'),
                        ),
                      ],
                      name: 'dropdown',
                    ),
                    FormeAutocomplete(
                        initialValue: 'c',
                        decoration: const InputDecoration(
                          labelText: 'Autocomplete',
                        ),
                        name: 'autocomplete',
                        optionsBuilder: (TextEditingValue value) {
                          return ['a', 'b', 'c'];
                        }),
                    TextButton(
                        onPressed: () {
                          key.reset();
                        },
                        child: const Text('reset form')),
                  ],
                )),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
