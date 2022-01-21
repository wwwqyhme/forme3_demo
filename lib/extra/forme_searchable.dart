import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_demo/extra/forme_searchable_content2.dart';
import 'package:forme_searchable/forme_searchable.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeSearchableFieldScreen extends FormeScreen {
  static Future<FormeSearchablePageResult<String>> _defaultQuery(
      Map<String, dynamic> condition, int page) {
    final String query = condition['query'] ?? '';
    if (query.isEmpty) {
      return Future.delayed(
          Duration.zero, () => FormeSearchablePageResult([], 1));
    }

    final List<String> result = [];

    for (int i = 10 * (page - 1); i < page * 10; i++) {
      result.add('$i');
    }
    return Future.delayed(const Duration(milliseconds: 800), () {
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
                  name: 'infinite',
                  field: FormeSearchable<String>.dialog(
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
                    selectableItemBuilder: (context, data, isSelected) {
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
                  name: 'dropdown',
                  field: FormeSearchable<String>.overlay(
                    name: 'dropdown',
                    query: _defaultQuery,
                    maxHeightProvider: (context) => 300,
                    contentBuilder: (context) {
                      return const FormeSearchableContent2<String>();
                    },
                    decorator: _DropdownlikeDecorator(),
                  ),
                  title: 'dropdown like',
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
                    onLimitExceeded: (context) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('max selectable num is 2')));
                    },
                  ),
                  title: 'Limit Selectable num',
                ),
              ];
            });
}

class _DropdownlikeDecorator<T extends Object>
    with FormeFieldDecorator<List<T>> {
  @override
  Widget build(FormeFieldController<List<T>> controller, Widget child) {
    return FormeInputDecoratorBuilder<List<T>>(
            decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder<List<T>>(
                        valueListenable: controller.valueListenable,
                        builder: (context, value, child) {
                          if (value.isNotEmpty) {
                            return IconButton(
                                onPressed: () {
                                  controller.value = [];
                                },
                                icon: const Icon(Icons.clear));
                          }
                          return const SizedBox.shrink();
                        }),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
                suffixIconConstraints: const BoxConstraints.tightFor()))
        .build(controller, child);
  }
}
