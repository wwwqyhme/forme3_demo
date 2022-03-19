import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

import '../example.dart';
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

  static String? validator(FormeFieldState controller, String? value) {
    return value == '0' || value == '1' ? null : 'pls select 0 or 1';
  }

  static Future<String?> asyncValidator(
      FormeFieldState controller, String? value, isValid) {
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
              ];
            });
}
