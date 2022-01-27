import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/field/material/forme_list_tile.dart';
import 'package:forme_base_fields/field/material/forme_radio_group.dart';
import 'package:forme_base_fields/field/material/forme_text_field.dart';
import 'package:forme_demo/extra/forme_pagination.dart';
import 'package:forme_demo/extra/forme_searchable_content2.dart';
import 'package:forme_searchable/forme_searchable.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeSearchableFieldScreen extends FormeScreen {
  static Future<FormeSearchablePageResult<String>> _defaultQuery(
      Map<String, dynamic> condition, int page) {
    // print('query condition:$condition');
    final String query = condition['query'] ?? '';
    final String? sex = condition['sex'];

    if (query.isEmpty && sex == null) {
      return Future.delayed(
          Duration.zero, () => FormeSearchablePageResult([], 1));
    }

    final List<String> result = [];

    for (int i = 10 * (page - 1); i < page * 10; i++) {
      result.add('option $i ${sex ?? ''}');
    }
    return Future.delayed(const Duration(milliseconds: 100), () {
      return FormeSearchablePageResult(result, 5);
    });
  }

  FormeSearchableFieldScreen({Key? key})
      : super(
            key: key,
            title: 'FormeSearchable',
            sourceCode: 'extra/forme_searchable',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'default',
                  field: FormeSearchable<String>(
                    maxHeightProvider: (context) => 300,
                    name: 'default',
                    query: _defaultQuery,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (field, value) {
                      return value.length < 2 ? 'must select at least 2' : null;
                    },
                  ),
                  title: 'Default',
                ),
                Example(
                  formeKey: key,
                  name: 'overlay',
                  field: FormeSearchable<String>.overlay(
                    maxHeightProvider: (context) => 300,
                    name: 'overlay',
                    query: _defaultQuery,
                  ),
                  title: 'Overlay mode',
                ),
                Example(
                  formeKey: key,
                  name: 'dialog',
                  subTitle: 'default is full screen',
                  field: FormeSearchable<String>.dialog(
                    name: 'dialog',
                    query: _defaultQuery,
                  ),
                  title: 'Dialog mode',
                ),
                Example(
                  formeKey: key,
                  name: 'bottomSheet',
                  field: FormeSearchable<String>.bottomSheet(
                    maxHeightProvider: (context) => 300,
                    name: 'bottomSheet',
                    query: _defaultQuery,
                    bottomSheetConfiguration: FormeBottomSheetConfiguration(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                  ),
                  title: 'BottomSheet mode',
                ),
                Example(
                  formeKey: key,
                  name: 'dialogSize',
                  field: FormeSearchable<String>.dialog(
                    name: 'dialogSize',
                    query: _defaultQuery,
                    sizeProvider: (context) {
                      final MediaQueryData mediaQueryData =
                          MediaQuery.of(context);
                      return Size(
                        mediaQueryData.size.width * 0.8,
                        mediaQueryData.size.height * 0.8,
                      );
                    },
                  ),
                  title: 'Customize dialog size',
                ),
                Example(
                  formeKey: key,
                  name: 'pagination',
                  field: FormeSearchable<String>(
                    maxHeightProvider: (context) => 300,
                    name: 'pagination',
                    query: _defaultQuery,
                    contentBuilder: (context) {
                      return FormeSearchableDefaultContent<String>(
                        paginationBarPosition: PaginationBarPosition.bottom,
                        elevation: 4,
                        paginationBuilder:
                            (context, listenable, onPageChanged) {
                          return FormePagination(
                              buttonActiveColor: Colors.deepPurple,
                              onPageChanged: onPageChanged,
                              notifier: listenable);
                        },
                      );
                    },
                  ),
                  title: 'Customize pagination',
                ),
                Example(
                  formeKey: key,
                  name: 'infinite',
                  field: FormeSearchable<String>.dialog(
                    dialogConfiguration:
                        FormeDialogConfiguration(barrierDismissible: true),
                    name: 'infinite',
                    query: _defaultQuery,
                    sizeProvider: (context) {
                      final MediaQueryData mediaQueryData =
                          MediaQuery.of(context);
                      return Size(
                        mediaQueryData.size.width * 0.8,
                        mediaQueryData.size.height * 0.8,
                      );
                    },
                    contentBuilder: (context) {
                      return const FormeSearchableContent2<String>();
                    },
                  ),
                  title: 'infinite scroll pagination',
                ),
                Example(
                  formeKey: key,
                  name: 'search',
                  field: FormeSearchable<String>(
                    maxHeightProvider: (context) => 300,
                    name: 'search',
                    query: _defaultQuery,
                    contentBuilder: (context) {
                      return FormeSearchableDefaultContent<String>(
                        performQueryWhenInitialed: true,
                        elevation: 4,
                        searchFieldsBuilder: (formKey, query, selectHighlight) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Forme(
                              onValueChanged: (p0, newValue) {
                                query();
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FormeTextField(
                                      name: 'query',
                                      decoration: const InputDecoration(),
                                    ),
                                  ),
                                  FormeRadioGroup(
                                    name: 'sex',
                                    initialValue: 'male',
                                    items: [
                                      FormeListTileItem(
                                          title: const Text('male'),
                                          data: 'male'),
                                      FormeListTileItem(
                                          title: const Text('female'),
                                          data: 'female')
                                    ],
                                    split: 0,
                                  ),
                                ],
                              ),
                              key: formKey,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  title: 'Customize search fields',
                ),
                Example(
                  formeKey: key,
                  name: 'style',
                  field: FormeSearchable<String>.dialog(
                    name: 'style',
                    query: _defaultQuery,
                    sizeProvider: (context) {
                      final MediaQueryData mediaQueryData =
                          MediaQuery.of(context);
                      return Size(
                        mediaQueryData.size.width * 0.8,
                        mediaQueryData.size.height * 0.8,
                      );
                    },
                    selectableItemBuilder: (context, index, data, isSelected) {
                      return Card(
                        child: ListTile(
                          leading: const FlutterLogo(),
                          title: Text(data),
                          subtitle: Text(isSelected
                              ? 'click to unselect'
                              : 'click to select'),
                        ),
                      );
                    },
                    selectedItemsBuilder: (context, selected, onDelete) {
                      return Wrap(
                        children: selected.map((e) {
                          return InputChip(
                            label: Text(e),
                            onDeleted: onDelete == null
                                ? null
                                : () {
                                    onDelete(e);
                                  },
                            avatar: const FlutterLogo(),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  title: 'Customize selected|selectable items',
                ),
                Example(
                  formeKey: key,
                  name: 'limit',
                  field: FormeSearchable<String>.dialog(
                    name: 'limit',
                    query: _defaultQuery,
                    sizeProvider: (context) {
                      final MediaQueryData mediaQueryData =
                          MediaQuery.of(context);
                      return Size(
                        mediaQueryData.size.width * 0.8,
                        mediaQueryData.size.height * 0.8,
                      );
                    },
                    limit: 2,
                    onLimitExceeded: (context, value, data) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('max selectable num is 2')));
                      return value;
                    },
                  ),
                  title: 'Limit Selectable num',
                ),
                Example(
                  formeKey: key,
                  name: 'button',
                  field: FormeSearchable<String>(
                    name: 'button',
                    multiSelect: false,
                    selectedItemsBuilder: (context, selected, onDelete) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(selected.isEmpty ? 'select one' : selected[0]),
                          if (onDelete != null && selected.isNotEmpty)
                            InkWell(
                              child: const Icon(
                                Icons.clear,
                                size: 14,
                              ),
                              onTap: () {
                                onDelete(selected[0]);
                              },
                            ),
                        ],
                      );
                    },
                    decorator: _ButtonDecorator(),
                    query: _defaultQuery,
                    contentPadding: const EdgeInsets.only(top: 10),
                    maxHeightProvider: (context) => 300,
                  ),
                  title: 'Single select',
                ),
              ];
            });
}

class _ButtonDecorator with FormeFieldDecorator<List<String>> {
  @override
  Widget build(FormeFieldController<List<String>> controller, Widget child) {
    return ElevatedButton(
        onPressed: () {
          (controller as FormeSearchableController).toggle();
        },
        child: child);
  }
}
