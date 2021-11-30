import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class AssociateValidationScreen extends StatefulWidget {
  const AssociateValidationScreen({Key? key}) : super(key: key);
  @override
  State<AssociateValidationScreen> createState() =>
      _AssociateValidationScreenState();
}

class _AssociateValidationScreenState extends State<AssociateValidationScreen> {
  final FormeKey key = FormeKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Associate Validation')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Forme(
            key: key,
            onValidationChanged: (f, v) {
              if (v.isValid) {
                (f.name == 'max' ? key.field('min') : key.field('max'))
                    .validate();
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormeNumberField(
                  name: 'min',
                  max: 100,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'min'),
                  validator: (f, v) {
                    if (v == null) {
                      return 'min can not be empty';
                    }
                    final num? max = key.field('max').value;
                    if (max != null && max < v) {
                      return 'min must be less than max';
                    }
                  },
                ),
                FormeNumberField(
                  name: 'max',
                  max: 100,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'max'),
                  validator: (f, v) {
                    if (v == null) {
                      return 'max can not be empty';
                    }
                    final num? min = key.field('min').value;
                    if (min != null && min > v) {
                      return 'max must be bigger than min';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
