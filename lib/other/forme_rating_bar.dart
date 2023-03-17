import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeRatingBarScreen extends FormeScreen {
  FormeRatingBarScreen({Key? key})
      : super(
            key: key,
            title: 'FormeRatingBar',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  field: FormeRatingBar(
                    decorator: FormeInputDecorationDecorator(
                        decorationBuilder: (context) =>
                            const InputDecoration(labelText: 'Rating Bar')),
                    name: 'rating',
                    initialValue: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (value, context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  subTitle: 'Example1',
                  title: 'FormeRatingBar',
                ),
                Example(
                  formeKey: key,
                  field: FormeRatingBar(
                    name: 'rating2',
                    initialValue: 3,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                        empty:
                            const Icon(Icons.star_border, color: Colors.amber),
                        full: const Icon(Icons.star, color: Colors.amber),
                        half: const Icon(Icons.star_half, color: Colors.amber)),
                  ),
                  subTitle: 'Example2',
                  title: 'FormeRatingBar',
                ),
                Example(
                  formeKey: key,
                  field: FormeRatingBar(
                    name: 'rating3',
                    initialValue: 3,
                    itemCount: 5,
                    itemBuilder: (value, context, index) {
                      if (value == 5) {
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      }
                      if (value == 4) {
                        return const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.green,
                        );
                      }

                      if (value == 3) {
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      }

                      if (value == 2) {
                        return const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      }

                      if (value == 1) {
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.redAccent,
                        );
                      }
                      return const Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    },
                  ),
                  subTitle: 'Example3',
                  title: 'FormeRatingBar',
                ),
                Example(
                  formeKey: key,
                  field: FormeRatingBarIndicator(
                    decorator: FormeInputDecorationDecorator(
                        childBuilder: (context, child) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            child,
                            FormeNumberField(
                              initialValue: 2.3,
                              decimal: 1,
                              max: 5,
                              decoration: const InputDecoration(
                                  labelText: 'Rating',
                                  border: InputBorder.none),
                              onStatusChanged: (f, v) {
                                if (v.isValueChanged && v.value != null) {
                                  key.field('rating4').value =
                                      v.value!.toDouble();
                                }
                              },
                            ),
                          ]);
                    }),
                    name: 'rating4',
                    initialValue: 2.3,
                    itemCount: 5,
                    itemSize: 50.0,
                  ),
                  subTitle: 'Example4',
                  title: 'FormeRatingBar',
                ),
              ];
            });
}
