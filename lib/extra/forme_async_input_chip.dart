import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeAsyncInputChipScreen extends FormeScreen {
  static Future<Iterable<String>> optionsBuilder(TextEditingValue value) =>
      Future.delayed(
          const Duration(milliseconds: 500),
          () => List.generate(100, (index) => '$index')
              .where((element) => element.contains(value.text)));

  static Widget inputChipBuilder(option, onDeleted) {
    return InputChip(
      label: Text(option),
      avatar: const FlutterLogo(),
      onDeleted: onDeleted,
    );
  }

  static String? validator(controller, List value) {
    return value.length < 2 ? 'invalid' : null;
  }

  static Future<String?> asyncValidator(controller, List value, isValid) {
    return Future.delayed(const Duration(milliseconds: 600), () {
      return value.length > 3 ? 'invalid' : null;
    });
  }

  FormeAsyncInputChipScreen({Key? key})
      : super(
            key: key,
            title: 'FormeAsyncInputChip',
            builder: (context, key) {
              return [
                Example(
                  subTitle: 'adjust options view height automatically ',
                  formeKey: key,
                  name: 'asyncInputChip',
                  field: FormeAsyncInputChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
                    optionsViewBuilder:
                        (controller, context, onSelected, options, width) {
                      double keyboardHeight =
                          MediaQuery.of(context).viewInsets.bottom;
                      RenderBox? box =
                          controller.context.findRenderObject() as RenderBox;
                      double unsafeAreaHeight = keyboardHeight == 0
                          ? MediaQuery.of(context).padding.bottom
                          : 0;
                      double height = max(
                          200,
                          MediaQuery.of(context).size.height -
                              box.localToGlobal(Offset.zero).dy -
                              box.size.height -
                              unsafeAreaHeight -
                              keyboardHeight -
                              5);
                      return FormeMultiAutocompleteOptions(
                        displayStringForOption:
                            RawAutocomplete.defaultStringForOption,
                        onSelected: onSelected,
                        options: options,
                        maxOptionsHeight: height,
                        width: width,
                      );
                    },
                    asyncValidator: asyncValidator,
                    inputChipBuilder: inputChipBuilder,
                    decoration: const InputDecoration(
                        labelText: 'FormeAsyncInputChip',
                        suffixIconConstraints: BoxConstraints.tightFor()),
                    name: 'asyncInputChip',
                    optionsBuilder: optionsBuilder,
                  ),
                  title: 'FormeAsyncInputChip',
                ),
                Example(
                  formeKey: key,
                  name: 'asyncInputChip2',
                  subTitle: 'custom field view',
                  field: FormeAsyncInputChip<String>(
                    fieldViewBuilder: (context, selected, controller,
                        textEditingController, focusNode, onSubmitted) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: selected
                                .map(
                                  (e) => InputChip(
                                    label: Text(e),
                                    onDeleted: controller.readOnly
                                        ? null
                                        : () {
                                            controller.delete(e);
                                          },
                                  ),
                                )
                                .toList(),
                          ),
                          TextField(
                            decoration: null,
                            focusNode: focusNode,
                            controller: textEditingController,
                            onSubmitted:
                                controller.readOnly ? null : (v) => onSubmitted,
                          ),
                        ],
                      );
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
                    asyncValidator: asyncValidator,
                    inputChipBuilder: inputChipBuilder,
                    decoration: const InputDecoration(
                        labelText: 'FormeAsyncInputChip',
                        suffixIconConstraints: BoxConstraints.tightFor()),
                    name: 'asyncInputChip2',
                    optionsBuilder: optionsBuilder,
                  ),
                  title: 'FormeAsyncInputChip2',
                ),
                Example(
                  formeKey: key,
                  name: 'asyncInputChip3',
                  subTitle: 'custom state ',
                  field: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormeAsyncInputChip<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validator,
                        asyncValidator: asyncValidator,
                        inputChipBuilder: inputChipBuilder,
                        decoration: const InputDecoration(
                          labelText: 'FormeAsyncInputChip',
                          suffixIconConstraints: BoxConstraints.tightFor(),
                          suffixIcon: SizedBox.shrink(),
                        ),
                        name: 'asyncInputChip3',
                        optionsBuilder: optionsBuilder,
                      ),
                      Builder(builder: (context) {
                        FormeAsyncInputChipController controller =
                            key.field('asyncInputChip3');

                        return ValueListenableBuilder3<
                                bool,
                                FormeAsyncAutocompleteSearchState,
                                FormeFieldValidation>(
                            controller.optionsViewVisibeStateListenable,
                            controller.stateListenable,
                            controller.validationListenable, builder:
                                (context, visible, state, validation, child) {
                          if (visible) {
                            return const SizedBox();
                          }
                          if (state ==
                              FormeAsyncAutocompleteSearchState.loading) {
                            return const Material(
                              elevation: 4.0,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text('loading'),
                              ),
                            );
                          }
                          if (validation.isValidating) {
                            return const Material(
                              elevation: 4.0,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text('validating'),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }),
                    ],
                  ),
                  title: 'FormeAsyncInputChip3',
                ),
                Example(
                  subTitle:
                      'single select options view (FormeAsyncAutocomplete like)',
                  formeKey: key,
                  name: 'asyncInputChip4',
                  field: FormeAsyncInputChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
                    optionsViewBuilder:
                        (controller, context, onSelected2, options, width) {
                      return AutocompleteOptions<String>(
                        displayStringForOption:
                            RawAutocomplete.defaultStringForOption,
                        onSelected: (t) => onSelected2([t]),
                        options: options,
                        maxOptionsHeight: 200,
                        width: width,
                      );
                    },
                    asyncValidator: asyncValidator,
                    inputChipBuilder: inputChipBuilder,
                    decoration: const InputDecoration(
                        labelText: 'FormeAsyncInputChip',
                        suffixIconConstraints: BoxConstraints.tightFor()),
                    name: 'asyncInputChip4',
                    optionsBuilder: optionsBuilder,
                  ),
                  title: 'FormeAsyncInputChip4',
                ),
              ];
            });
}
