import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeSliderScreen extends FormeScreen {
  FormeSliderScreen({Key? key})
      : super(
            key: key,
            title: 'FormeSlider',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'slider',
                  field: FormeSlider(
                    decoration: const InputDecoration(labelText: 'FormeSlider'),
                    min: 1,
                    max: 100,
                    name: 'slider',
                  ),
                  title: 'FormeSlider',
                ),
                Example(
                  subTitle: 'custom thumb shape',
                  formeKey: key,
                  name: 'slider2',
                  field: SliderTheme(
                    data: const SliderThemeData(
                        thumbShape: RoundSliderThumbShape()),
                    child: FormeSlider(
                      decoration:
                          const InputDecoration(labelText: 'FormeSlider'),
                      min: 1,
                      max: 100,
                      name: 'slider2',
                    ),
                  ),
                  title: 'FormeSlider',
                ),
                Example(
                  formeKey: key,
                  name: 'range-slider',
                  field: FormeRangeSlider(
                    decoration:
                        const InputDecoration(labelText: 'FormeRangeSlider'),
                    min: 1,
                    max: 100,
                    name: 'range-slider',
                  ),
                  title: 'FormeRangeSlider',
                )
              ];
            });
}
