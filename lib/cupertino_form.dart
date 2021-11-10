import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class CupertinoFormScreen extends StatefulWidget {
  const CupertinoFormScreen({Key? key}) : super(key: key);
  @override
  State<CupertinoFormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<CupertinoFormScreen> {
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
        title: const Text('CupertinoForm'),
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
                    FormeCupertinoTextField(
                      name: 'cupertinoField',
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('email')),
                    ),
                    FormeCupertinoDateTimeField(
                      name: 'birthday2',
                      type: FormeDateTimeType.dateTime,
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('birthday')),
                    ),
                    FormeCupertinoNumberField(
                      name: 'age2',
                      max: 100,
                      decimal: 2,
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('age')),
                    ),
                    FormeCupertinoSlider(
                      name: 'slider2',
                      min: 1,
                      max: 100,
                      decorator: FormeCupertinoSliderFullWidthDecorator(
                          prefix: const Label('slider2')),
                    ),
                    FormeCupertinoSwitch(
                      name: 'switch2',
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('switch2')),
                    ),
                    FormeCupertinoTimerField(
                      name: 'timer',
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('timer')),
                    ),
                    FormeCupertinoSegmentedControl<String>(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      disableBorderColor: CupertinoColors.systemGrey,
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('control')),
                      validator:
                          FormeValidates.equals('C', errorText: 'pls select C'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'segmentedControl',
                      children: const {
                        'A': Text('A'),
                        'B': Text('B'),
                        'C': Text('C'),
                      },
                    ),
                    FormeCupertinoSlidingSegmentedControl<String>(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decorator: const FormeCupertinoInputDecoratorBuilder(
                          prefix: Label('control')),
                      validator:
                          FormeValidates.equals('C', errorText: 'pls select C'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'slidingSegmentedControl',
                      children: const {
                        'A': Text('A'),
                        'B': Text('B'),
                        'C': Text('C'),
                      },
                    ),
                    FormeCupertinoPicker(
                        decorator: const FormeCupertinoInputDecoratorBuilder(
                            prefix: Label('picker')),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormeValidates.all([
                          FormeValidates.notNull(),
                          FormeValidates.min(100),
                        ], errorText: 'value must bigger than 100'),
                        name: 'picker',
                        initialValue: 50,
                        itemExtent: 50,
                        children: List<Widget>.generate(
                            1000, (index) => Text(index.toString()))),
                  ],
                )),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Label extends StatelessWidget {
  final String label;

  const Label(
    this.label, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(label),
      ),
    );
  }
}
