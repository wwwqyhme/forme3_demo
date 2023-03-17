import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
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
                  field: FormeSlider(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (field, value) {
                      return 'always error';
                    },
                    decoration: const InputDecoration(labelText: 'FormeSlider'),
                    min: 1,
                    max: 100,
                    name: 'slider',
                  ),
                  title: 'FormeSlider',
                ),
                Example(
                  formeKey: key,
                  subTitle: 'secondaryTrackValue',
                  field: FormeSlider(
                    decoration: const InputDecoration(labelText: 'FormeSlider'),
                    min: 1,
                    max: 100,
                    name: 'slider3',
                    secondaryTrackValue: 50,
                    secondaryActiveColor: Colors.red,
                  ),
                  title: 'FormeSlider',
                ),
                Example(
                  subTitle: 'custom thumb shape',
                  formeKey: key,
                  field: FormeSlider(
                    sliderThemeData: const SliderThemeData(
                        thumbShape: RoundSliderThumbShape()),
                    decoration: const InputDecoration(labelText: 'FormeSlider'),
                    min: 1,
                    max: 100,
                    name: 'slider2',
                  ),
                  title: 'FormeSlider',
                ),
                Example(
                  formeKey: key,
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
