import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';
import 'package:forme_fields/forme_fields.dart';

import 'forme_screen.dart';
import 'exmaple.dart';

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

  static Future<String?> asyncValidator(controller, List value) {
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
                  formeKey: key,
                  name: 'asyncInputChip',
                  field: FormeAsyncInputChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
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
                  subTitle: 'custom state icon',
                  field: FormeAsyncInputChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validator,
                    asyncValidator: asyncValidator,
                    inputChipBuilder: inputChipBuilder,
                    decoration: InputDecoration(
                      labelText: 'FormeAsyncInputChip',
                      suffixIconConstraints: const BoxConstraints.tightFor(),
                      suffixIcon: Builder(
                        builder: (context) {
                          FormeAsyncInputChipController<String> controller =
                              key.field('asyncInputChip3');
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<
                                      FormeAsyncAutocompleteSearchState>(
                                  valueListenable: controller.stateListenable,
                                  builder: (context, state, child) {
                                    return state ==
                                            FormeAsyncAutocompleteSearchState
                                                .loading
                                        ? const CircularProgressIndicator()
                                        : const SizedBox.shrink();
                                  }),
                              ValueListenableBuilder<FormeFieldValidation>(
                                  valueListenable:
                                      controller.validationListenable,
                                  builder: (context, validation, child) {
                                    return validation.isValidating
                                        ? const CircularProgressIndicator()
                                        : const SizedBox.shrink();
                                  }),
                            ],
                          );
                        },
                      ),
                    ),
                    name: 'asyncInputChip3',
                    optionsBuilder: optionsBuilder,
                  ),
                  title: 'FormeAsyncInputChip3',
                ),
              ];
            });
}
