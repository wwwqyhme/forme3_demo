import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FormeKey key = FormeKey();
  final User user = User();

  final List<FormeListTileItem<String>> items = [
    FormeListTileItem(
      title: const Text('Cooking'),
      data: 'Cooking',
      padding: const EdgeInsets.symmetric(horizontal: 20),
    ),
    FormeListTileItem(
      title: const Text('Traveling'),
      data: 'Traveling',
      padding: const EdgeInsets.symmetric(horizontal: 20),
    ),
    FormeListTileItem(
      title: const Text('Hiking'),
      data: 'Hiking',
      padding: const EdgeInsets.symmetric(horizontal: 20),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Forme(
            onValueChanged: (f, v) {
              print(
                  '${f.name} value changed: old value:${f.oldValue}, new value:$v');
            },
            onFocusChanged: (f, focus) {
              print('${f.name} focus changed: is focused:$focus');
            },
            onValidationChanged: (f, validation) {
              print('${f.name} validation changed: current:$validation');
            },
            autovalidateMode: AutovalidateMode.always,
            autovalidateByOrder: true,
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormeTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (f, v) {
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(v)) {
                      return 'Please enter valid email address';
                    }
                  },
                  asyncValidator: (f, v, isValid) {
                    return Future.delayed(const Duration(milliseconds: 800),
                        () {
                      if (v.length < 10) {
                        return 'email address is exists';
                      }
                    });
                  },
                  onSaved: (f, v) {
                    user.email = v;
                  },
                ),
                Builder(
                  builder: (context) {
                    return ValueListenableBuilder<FormeFieldValidation>(
                        valueListenable:
                            key.field('email').validationListenable,
                        builder: (context, validation, child) {
                          if (validation.isValidating) {
                            return const Text('async validating...');
                          }
                          return const SizedBox.shrink();
                        });
                  },
                ),
                FormeTextField(
                  name: 'firstName',
                  decoration: const InputDecoration(
                    labelText: 'First name',
                  ),
                  validator: (f, v) {
                    if (v.isEmpty) {
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (f, v) {
                    user.firstName = v;
                  },
                ),
                FormeTextField(
                  name: 'lastName',
                  decoration: const InputDecoration(
                    labelText: 'Last name',
                  ),
                  validator: (f, v) {
                    if (v.isEmpty) {
                      return 'Please enter your last name';
                    }
                  },
                  onSaved: (f, v) {
                    user.lastName = v;
                  },
                ),
                const SizedBox(height: 8),
                FormeSpinNumberField(
                  decorator: const FormeInputDecoratorBuilder(
                    decoration: InputDecoration(
                      labelText: 'Age',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  initialValue: 14,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  min: 14,
                  max: 99,
                  name: 'age',
                  onSaved: (f, v) {
                    user.age = v.toInt();
                  },
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: const Text('Subscribe'),
                ),
                FormeSwitchTile(
                  name: 'newsLetter',
                  title: const Text('Monthly Newsletter'),
                  initialValue: false,
                  onSaved: (f, v) {
                    user.newsletter = v;
                  },
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: const Text('Interests'),
                ),
                FormeListTile<String>(
                  name: 'interests',
                  split: 1,
                  validator: (f, v) {
                    if (v.isEmpty) {
                      return 'Please select interest';
                    }
                  },
                  onSaved: (f, v) {
                    (user.interests..clear()).addAll(v);
                  },
                  items: items,
                ),
                Builder(
                  builder: (context) {
                    return ValueListenableBuilder<FormeFieldValidation>(
                        valueListenable:
                            key.field('interests').validationListenable,
                        builder: (context, validation, child) {
                          if (validation.isInvalid) {
                            return Text(validation.error!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                ));
                          }
                          return const SizedBox.shrink();
                        });
                  },
                ),
                FormeDropdownButton<String>(
                  decoration: const InputDecoration(labelText: 'Sex'),
                  name: 'sex',
                  items: const [
                    DropdownMenuItem(
                      child: Text('male'),
                      value: 'male',
                    ),
                    DropdownMenuItem(
                      child: Text('female'),
                      value: 'female',
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                            key.validate(quietly: false).then((value) {
                              if (value.isValid &&
                                  !value.isValueChangedDuringValidation) {
                                key.save();
                                print(user);
                                _showDialog(context);
                              }
                            });
                          },
                          child: const Text('Save'),
                        );
                      },
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                            key.reset();
                          },
                          child: const Text('reset'),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Submitting form')));
  }
}

class User {
  String email = '';
  String firstName = '';
  String lastName = '';
  int age = 14;
  bool newsletter = false;
  List<String> interests = [];

  @override
  String toString() {
    return '[email:$email,firstName:$firstName,lastName:$lastName,newsletter:$newsletter,interests:$interests]';
  }
}
