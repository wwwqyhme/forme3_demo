import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';

import '../exmaple.dart';
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
                  name: 'filter-chip',
                  field: FormeFilterChip<Tech>(
                    decorator: FormeInputDecoratorBuilder(
                        decoration:
                            const InputDecoration(labelText: 'FormeFilterChip'),
                        wrapper: (w, controller) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: w,
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
                  name: 'filter-chip2',
                  field: FormeFilterChip<Tech>(
                    maxSelectedCount: 2,
                    maxSelectedExceedCallback: () {
                      print('max select count is 2');
                    },
                    decorator: FormeInputDecoratorBuilder(
                        decoration:
                            const InputDecoration(labelText: 'FormeFilterChip'),
                        wrapper: (w, controller) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: w,
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
                  name: 'choice-chip2',
                  field: FormeChoiceChip<Tech>(
                    decorator: FormeInputDecoratorBuilder(
                        decoration:
                            const InputDecoration(labelText: 'FormeChoiceChip'),
                        wrapper: (w, controller) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: w,
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
