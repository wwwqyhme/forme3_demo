import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

class DynamicFieldsScreen extends StatefulWidget {
  const DynamicFieldsScreen({Key? key}) : super(key: key);
  @override
  State<DynamicFieldsScreen> createState() => _DynamicFieldsScreenState();
}

class _DynamicFieldsScreenState extends State<DynamicFieldsScreen> {
  final FormeKey key = FormeKey();

  final ValueNotifier<List<Widget>> widgets = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    widgets.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Fields')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Forme(
            onFieldsChanged: (name, field) {
              if (field == null) {
                print('$name unregistered');
              } else {
                print('$name registered');
              }
            },
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.of(widgets.value)
                ..add(Builder(
                  builder: (context) {
                    return ValueListenableBuilder<
                            FormeFieldController<String>?>(
                        valueListenable: key.fieldListenable<String>('email'),
                        builder: (context, f, child) {
                          if (f == null) {
                            return const SizedBox.shrink();
                          }
                          return ValueListenableBuilder<FormeFieldValidation>(
                              valueListenable: f.validationListenable,
                              builder: (context, validation, child) {
                                if (validation.isValid) {
                                  return FormeTextField(
                                    name: 'address',
                                    decoration: const InputDecoration(
                                        labelText: 'Address'),
                                  );
                                }
                                return const SizedBox.shrink();
                              });
                        });
                  },
                ))
                ..addAll([
                  _Scope(
                    Wrap(
                      children: [
                        _Button(
                          FormeTextField(
                              name: 'email',
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  labelText: 'email',
                                  helperText:
                                      'input a valid email(length > 10) , address field will be auto created'),
                              validator: (f, v) {
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(v)) {
                                  return 'Please enter valid email address';
                                }
                              },
                              asyncValidator: (f, v, isValid) {
                                return Future.delayed(
                                    const Duration(seconds: 1), () {
                                  if (v.length < 10) {
                                    return 'Email is exists';
                                  }
                                });
                              }),
                          'Remove Email',
                          'Append Email',
                        ),
                        _Button(
                          FormeSpinNumberField(
                            name: 'age',
                            min: 14,
                            max: 100,
                            initialValue: 30,
                          ),
                          'Remove Age',
                          'Append Age',
                        ),
                        TextButton(
                          child: const Text('get form data'),
                          onPressed: () {
                            print(key.data);
                          },
                        ),
                      ],
                    ),
                    key,
                    widgets,
                  ),
                ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _Scope extends InheritedWidget {
  final FormeKey formeKey;
  final ValueNotifier<List<Widget>> widgets;
  const _Scope(
    Widget child,
    this.formeKey,
    this.widgets,
  ) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static _Scope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_Scope>()!;
  }

  void removeFormeField(String name) {
    widgets.value = List.of(widgets.value)
      ..removeWhere((element) {
        return element is FormeField && element.name == name;
      });
  }

  void appendFormeField(FormeField field) {
    widgets.value = List.of(widgets.value)..add(field);
  }
}

class _Button extends StatelessWidget {
  final FormeField field;
  final String removeText;
  final String appendText;
  const _Button(
    this.field,
    this.removeText,
    this.appendText,
  ) : super(key: null);

  @override
  Widget build(BuildContext context) {
    _Scope scope = _Scope.of(context);
    FormeKey key = scope.formeKey;
    return ValueListenableBuilder<FormeFieldController?>(
        valueListenable: key.fieldListenable(field.name),
        builder: (context, f, child) {
          return TextButton(
              child: f != null ? Text(removeText) : Text(appendText),
              onPressed: () {
                if (f == null) {
                  scope.appendFormeField(field);
                } else {
                  scope.removeFormeField(field.name);
                }
              });
        });
  }
}
