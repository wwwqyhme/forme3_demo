import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

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
                  field: FormeDateTimeField(
                    validator: (field, value) {
                      return 'always error';
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    triggerBuilder: (state) {
                      return InkWell(
                        focusNode: state.focusNode,
                        onTap: state.showPicker,
                        child: InputDecorator(
                          isFocused: state.hasFocus,
                          isEmpty: state.value == null,
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            labelText: 'Date',
                            suffixIcon: FormeFieldStatusListener<DateTime?>(
                              builder: (context, status, child) {
                                if (status != null && status.value != null) {
                                  return IconButton(
                                    onPressed: () {
                                      key.field('dateTime').value = null;
                                    },
                                    icon: const Icon(Icons.clear),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          child: Text('${state.value ?? ''}'),
                        ),
                      );
                    },
                    name: 'dateTime',
                  ),
                  title: 'FormeDateTimeField',
                ),
                Example(
                  subTitle: 'select both date and time',
                  formeKey: key,
                  field: FormeDateTimeField(
                    type: FormeDateTimeType.dateTime,
                    triggerBuilder: (state) {
                      return InkWell(
                        focusNode: state.focusNode,
                        onTap: state.showPicker,
                        child: InputDecorator(
                          isFocused: state.hasFocus,
                          isEmpty: state.value == null,
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            labelText: 'DateTime',
                          ),
                          child: Text('${state.value ?? ''}'),
                        ),
                      );
                    },
                    name: 'dateTime2',
                  ),
                  title: 'FormeDateTimeField2',
                ),
                Example(
                  subTitle: 'select time only',
                  formeKey: key,
                  field: FormeTimeField(
                    triggerBuilder: (state) {
                      return InkWell(
                        focusNode: state.focusNode,
                        onTap: state.showPicker,
                        child: InputDecorator(
                          isFocused: state.hasFocus,
                          isEmpty: state.value == null,
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            labelText: 'Time',
                          ),
                          child: Text('${state.value ?? ''}'),
                        ),
                      );
                    },
                    name: 'time',
                  ),
                  title: 'FormeTimeField',
                ),
                Example(
                  subTitle: 'select date-range',
                  formeKey: key,
                  field: FormeDateRangeField(
                    triggerBuilder: (state) {
                      return InkWell(
                        focusNode: state.focusNode,
                        onTap: state.showPicker,
                        child: InputDecorator(
                          isFocused: state.hasFocus,
                          isEmpty: state.value == null,
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            labelText: 'DateRange',
                          ),
                          child: Text('${state.value ?? ''}'),
                        ),
                      );
                    },
                    name: 'range',
                  ),
                  title: 'FormeDateTimeRangeField',
                ),
              ];
            });
}
