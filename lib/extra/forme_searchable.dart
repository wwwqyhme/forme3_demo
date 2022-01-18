import 'package:flutter/material.dart';
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
                    heightProvider: (context) => 300,
                    name: 'bottomSheet',
                    query: _defaultQuery,
                    bottomSheetConfiguration: FormeBottomSheetConfiguration(
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
                  name: 'dialog2',
                  subTitle:
                      'disable pagination via FormePaginationConfiguration or auto disabled when totalPage is 1',
                  field: FormeSearchable<String>.dialog(
                    name: 'dialog2',
                    query: _defaultQuery,
                    contentWidgetBuilder:
                        (formKey, query, result, state, currentPage) {
                      return FormeSearchableContent(
                        result: result,
                        formKey: formKey,
                        onPageChanged: query,
                        state: state,
                        currentPage: currentPage,
                        paginationConfiguration:
                            const FormePaginationConfiguration(enable: false),
                      );
                    },
                  ),
                  title: 'No Pagination',
                ),
                Example(
                  formeKey: key,
                  name: 'dialogSize',
                  field: FormeSearchable<String>.dialog(
                    name: 'dialogSize',
                    query: _defaultQuery,
                    heightFactorProvider: (context) => 0.5,
                    widthFactorProvider: (context) => 0.5,
                  ),
                  title: 'Dialog size',
                ),
                Example(
                  formeKey: key,
                  name: 'limit',
                  field: FormeSearchable<String>.dialog(
                    name: 'limit',
                    query: _defaultQuery,
                    heightFactorProvider: (context) => 0.5,
                    widthFactorProvider: (context) => 0.5,
                    limit: 2,
                    onLimitExceeded: (context) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('max selectable num is 2')));
                    },
                  ),
                  title: 'Limit Selectable num',
                ),
              ];
            });
}
