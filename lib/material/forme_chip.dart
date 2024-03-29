import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeChipScreen extends FormeScreen {
  static const List<Tech> _chipsList = [
    Tech(
      "Android",
      Colors.green,
    ),
    Tech(
      "Flutter",
      Colors.blueGrey,
    ),
    Tech(
      "Ios",
      Colors.deepOrange,
    ),
    Tech(
      "Python",
      Colors.cyan,
    ),
    Tech(
      "Go lang",
      Colors.yellow,
    )
  ];
  FormeChipScreen({Key? key})
      : super(
            key: key,
            title: 'FormeChip',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  field: FormeFilterChip<Tech>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormeValidates.notEmpty(errorText: 'required'),
                    decorator: FormeInputDecorationDecorator(
                        decorationBuilder: (context) =>
                            const InputDecoration(labelText: 'FormeFilterChip'),
                        childBuilder: (context, child) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: child,
                            )),
                    items: _chipsList.map((e) {
                      return FormeChipItem(
                        label: Text(e.label),
                        labelStyle: const TextStyle(color: Colors.white),
                        data: e,
                        backgroundColor: e.color,
                      );
                    }).toList(),
                    name: 'filter-chip',
                  ),
                  title: 'FormeFilterChip',
                ),
                Example(
                  subTitle: 'max selected count 2',
                  formeKey: key,
                  field: FormeFilterChip<Tech>(
                    maxSelectedCount: 2,
                    maxSelectedExceedCallback: () {
                      debugPrint('max select count is 2');
                    },
                    decorator: FormeInputDecorationDecorator(
                        decorationBuilder: (context) =>
                            const InputDecoration(labelText: 'FormeFilterChip'),
                        childBuilder: (context, child) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: child,
                            )),
                    items: _chipsList.map((e) {
                      return FormeChipItem(
                        label: Text(e.label),
                        labelStyle: const TextStyle(color: Colors.white),
                        data: e,
                        backgroundColor: e.color,
                      );
                    }).toList(),
                    name: 'filter-chip2',
                  ),
                  title: 'FormeFilterChip2',
                ),
                Example(
                  formeKey: key,
                  field: FormeChoiceChip<Tech>(
                    decorator: FormeInputDecorationDecorator(
                        decorationBuilder: (context) =>
                            const InputDecoration(labelText: 'FormeChoiceChip'),
                        childBuilder: (context, child) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: child,
                            )),
                    items: _chipsList.map((e) {
                      return FormeChipItem(
                        label: Text(e.label),
                        labelStyle: const TextStyle(color: Colors.white),
                        data: e,
                        backgroundColor: e.color,
                      );
                    }).toList(),
                    name: 'choice-chip2',
                  ),
                  title: 'FormeChoiceChip',
                )
              ];
            });
}

class Tech {
  final String label;
  final Color color;
  const Tech(this.label, this.color);
  @override
  String toString() {
    return label;
  }
}
