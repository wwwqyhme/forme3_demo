import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../exmaple.dart';
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
                  name: 'rating',
                  field: FormeRatingBar(
                    decorator: const FormeInputDecoratorBuilder(
                        decoration: InputDecoration(labelText: 'Rating Bar')),
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
                  name: 'rating2',
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
                  name: 'rating3',
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
                  name: 'rating4',
                  field: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormeRatingBarIndicator(
                        name: 'rating4',
                        initialValue: 2.3,
                        itemCount: 5,
                        itemSize: 50.0,
                      ),
                      FormeNumberField(
                        name: '',
                        registrable: false,
                        initialValue: 2.3,
                        decimal: 1,
                        max: 5,
                        decoration: const InputDecoration(labelText: 'Rating'),
                        onValueChanged: (f, v) {
                          if (v != null) {
                            key.field('rating4').value = v.toDouble();
                          }
                        },
                      ),
                    ],
                  ),
                  subTitle: 'Example4',
                  title: 'FormeRatingBar',
                ),
              ];
            });
}
