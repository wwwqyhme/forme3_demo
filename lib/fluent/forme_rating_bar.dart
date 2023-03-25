import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/fluent_example.dart';
import 'package:forme_fluent/forme_fluent.dart';
import '../forme_screen.dart';

class FormeFluentRatingBarScreen extends FormeScreen {
  FormeFluentRatingBarScreen({Key? key})
      : super(
            title: 'FormeFluentRatingBar',
            key: key,
            builder: (context, key) {
              return [
                FluentExample(
                  formeKey: key,
                  name: 'rating',
                  title: '',
                  field: Column(children: [
                    FormeFluentRatingBar(
                      name: 'rating',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: 2,
                      unratedIconColor: Colors.grey,
                      validator: FormeValidates.min(2.5, errorText: '> 2.5'),
                    ),
                    FormeFieldStatusListener<double>(
                        name: 'rating',
                        builder: (context, status, child) {
                          if (status == null) {
                            return const SizedBox.shrink();
                          }
                          if (status.validation.isInvalid) {
                            return Text(
                              status.validation.error!,
                              style: const TextStyle(
                                  color: Colors.errorPrimaryColor),
                            );
                          }
                          return Text('${status.value}');
                        }),
                  ]),
                ),
              ];
            });
}
