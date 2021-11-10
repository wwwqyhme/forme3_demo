import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';

import 'forme_screen.dart';
import 'exmaple.dart';

class FormeTimeFieldScreen extends FormeScreen {
  FormeTimeFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormeDateTimeField',
            builder: (context, key) {
              return [
                Example(
                  subTitle: 'select date only',
                  formeKey: key,
                  name: 'dateTime',
                  field: FormeDateTimeField(
                    decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: Builder(
                          builder: (context) {
                            return ValueListenableBuilder(
                                valueListenable:
                                    key.field('dateTime').valueListenable,
                                builder: (context, value, child) {
                                  if (value != null) {
                                    return IconButton(
                                      onPressed: () {
                                        key.field('dateTime').value = null;
                                      },
                                      icon: const Icon(Icons.clear),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                });
                          },
                        )),
                    name: 'dateTime',
                  ),
                  title: 'FormeDateTimeField',
                ),
                Example(
                  subTitle: 'select both date and time',
                  formeKey: key,
                  name: 'dateTime2',
                  field: FormeDateTimeField(
                    type: FormeDateTimeType.dateTime,
                    decoration: const InputDecoration(
                      labelText: 'DateTime',
                    ),
                    name: 'dateTime2',
                  ),
                  title: 'FormeDateTimeField2',
                ),
                Example(
                  subTitle: 'custom formatter',
                  formeKey: key,
                  name: 'dateTime3',
                  field: FormeDateTimeField(
                    formatter: (type, dateTime) {
                      switch (type) {
                        case FormeDateTimeType.date:
                          return '${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}';
                        case FormeDateTimeType.dateTime:
                          return '${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                    name: 'dateTime3',
                  ),
                  title: 'FormeDateTimeField3',
                ),
                Example(
                  subTitle: 'select time only',
                  formeKey: key,
                  name: 'time',
                  field: FormeTimeField(
                    decoration: const InputDecoration(
                      labelText: 'Time',
                    ),
                    name: 'time',
                  ),
                  title: 'FormeTimeField',
                ),
                Example(
                  subTitle: 'select date-range',
                  formeKey: key,
                  name: 'range',
                  field: FormeDateTimeRangeField(
                    decoration: const InputDecoration(
                      labelText: 'Date-Time-Range',
                    ),
                    name: 'range',
                  ),
                  title: 'FormeDateTimeRangeField',
                ),
              ];
            });
}
