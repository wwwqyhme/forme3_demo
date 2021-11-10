import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme_fields/forme_fields.dart';

import 'forme_screen.dart';
import 'exmaple.dart';

class FormeAsyncChipInputScreen extends FormeScreen {
  FormeAsyncChipInputScreen({Key? key})
      : super(
            key: key,
            title: 'FormeAsyncChipInput',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'asyncChipInput',
                  field: FormeAsyncChipInput<String>(
                    name: 'asyncChipInput',
                    validator: (f, v) => '123',
                    decoration:
                        InputDecoration(labelText: 'FormeAsyncChipInput'),
                    optionsBuilder: (value) => Future.delayed(
                        const Duration(milliseconds: 800),
                        () => ['a', 'b', 'c']),
                  ),
                  title: 'FormeAsyncChipInput',
                ),
              ];
            });
}
