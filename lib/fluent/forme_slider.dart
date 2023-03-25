import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import '../forme_screen.dart';

class FormeFluentSliderScreen extends FormeScreen {
  FormeFluentSliderScreen({Key? key})
      : super(
            title: 'FormeFluentSlider',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'slider',
                  title: 'Normal',
                  field: FormeFluentSlider(
                    decorator: const FormeFluentFormRowDecorator.noPadding(),
                    name: 'slider',
                    validator: FormeValidates.min(50, errorText: '> 50'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                FluentExample(
                    formeKey: key,
                    name: 'slider2',
                    title: 'Vertical',
                    field: FormeFluentSlider(
                      decorator: const FormeFluentFormRowDecorator.noPadding(),
                      name: 'slider2',
                      vertical: true,
                      validator: FormeValidates.min(50, errorText: '> 50'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    )),
              ];
            });
}
