import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeAutocompleteScreen extends FormeScreen {
  static Iterable<String> search(TextEditingValue value) {
    return List.generate(100, (index) => index.toString())
        .where((element) => element.contains(value.text));
  }

  static Future<Iterable<String>> asyncSearch(TextEditingValue value) {
    return Future.delayed(const Duration(milliseconds: 800), () {
      return search(value);
    });
  }

  static String? validator(FormeFieldController controller, String? value) {
    return value == '0' || value == '1' ? null : 'pls select 0 or 1';
  }

  static Future<String?> asyncValidator(
      FormeFieldController controller, String? value, isValid) {
    return Future.delayed(const Duration(milliseconds: 500),
        () => value == '0' ? null : 'pls select 0');
  }

  FormeAutocompleteScreen({Key? key})
      : super(
            key: key,
            title: 'FormeAutocomplete',
            builder: (context, key) {
              return [
                Example(
                    formeKey: key,
                    name: 'autocomplete',
                    field: FormeAutocomplete<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validator,
                      asyncValidator: asyncValidator,
                      decoration: const InputDecoration(labelText: 'Search'),
                      optionsBuilder: search,
                      name: 'autocomplete',
                    ),
                    title: 'FormeAutocomplete'),
                Example(
                    formeKey: key,
                    name: 'asyncAutocomplete',
                    field: FormeAsyncAutocomplete<String>(
                      validator: validator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(labelText: 'Search'),
                      optionsBuilder: asyncSearch,
                      name: 'asyncAutocomplete',
                    ),
                    title: 'FormeAsyncAutocomplete'),
                Example(
                    formeKey: key,
                    name: 'asyncAutocomplete2',
                    field: FormeAsyncAutocomplete<String>(
                      searchCondition: (v) => v.text.isNotEmpty,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validator,
                      asyncValidator: asyncValidator,
                      decoration: const InputDecoration(labelText: 'Search'),
                      optionsBuilder: asyncSearch,
                      name: 'asyncAutocomplete2',
                    ),
                    title: 'FormeAsyncAutocomplete2',
                    subTitle: 'no search if search field is empty'),
                Example(
                    formeKey: key,
                    name: 'asyncAutocomplete3',
                    field: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormeAsyncAutocomplete<String>(
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5.0),
                            ),
                            suffixIcon: SizedBox.shrink(),
                          ),
                          validator: validator,
                          asyncValidator: asyncValidator,
                          optionsBuilder: asyncSearch,
                          name: 'asyncAutocomplete3',
                        ),
                        Builder(builder: (BuildContext context) {
                          return ValueListenableBuilder<
                                  FormeAsyncOperationState?>(
                              valueListenable: (key.field('asyncAutocomplete3')
                                      as FormeAsnycAutocompleteController)
                                  .stateListenable,
                              builder: (context, state, child) {
                                if (state == null) {
                                  return const Text('wait for search');
                                }
                                switch (state) {
                                  case FormeAsyncOperationState.processing:
                                    return const Text('searching...');
                                  case FormeAsyncOperationState.success:
                                    return const Text('search complete');
                                  case FormeAsyncOperationState.error:
                                    return const Text(
                                        'error occured when searching');
                                }
                              });
                        }),
                      ],
                    ),
                    title: 'FormeAsyncAutocomplete3',
                    subTitle: 'custom search state'),
              ];
            });
}
