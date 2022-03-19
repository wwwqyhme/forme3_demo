import 'package:flutter/material.dart';
import 'package:forme_fields/forme_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeSpinNumberFieldScreen extends FormeScreen {
  FormeSpinNumberFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormeSpinNumberField',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  field: FormeSpinNumberField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    name: 'spin',
                    initialValue: 50,
                    min: 0,
                    max: 100,
                    step: 0.3,
                    decimal: 1,
                  ),
                  title: 'FormeSpinNumberField',
                ),
                Example(
                  formeKey: key,
                  field: FormeSpinNumberField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    name: 'spin2',
                    initialValue: 50,
                    min: 0,
                    max: 100,
                    step: 0.3,
                    decimal: 1,
                    strictStep: true,
                  ),
                  subTitle: 'Strict Step',
                  title: 'FormeSpinNumberField',
                ),
              ];
            });
}
