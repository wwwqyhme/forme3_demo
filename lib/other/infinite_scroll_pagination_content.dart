import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:forme_searchable/forme_searchable.dart';

class InfiniteScrollPaginationContentView<T extends Object>
    extends FormeSearchableField<T> {
  const InfiniteScrollPaginationContentView({Key? key}) : super(key: key);

  @override
  FormeSearchableFieldState<T> createState() =>
      _InfiniteScrollPaginationContentViewState<T>();
}

class _InfiniteScrollPaginationContentViewState<T extends Object>
    extends FormeSearchableFieldState<T> {
  final PagingController<int, T> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      goToPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PagedListView<int, T>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<T>(
          itemBuilder: (context, item, index) => InkWell(
            onTap: status.readOnly
                ? null
                : () {
                    _toggle(item);
                  },
            child: ListTile(
              leading:
                  status.value.contains(item) ? const Icon(Icons.check) : null,
              title: Text('$item'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void onQueryFail(
      FormeSearchCondition condition, Object error, StackTrace trace) {
    super.onQueryFail(condition, error, trace);
    _pagingController.error = error;
  }

  @override
  void onQueryCancelled(FormeSearchCondition condition) {
    super.onQueryCancelled(condition);
    _pagingController.value = PagingState<int, T>(
        nextPageKey: 1, itemList: List.empty(growable: true));
  }

  @override
  void onConditionChangeStart(FormeSearchCondition condition) {
    super.onConditionChangeStart(condition);
    _pagingController.value =
        PagingState<int, T>(nextPageKey: 1, itemList: null);
  }

  @override
  void onQuerySuccess(
      FormeSearchCondition condition, FormeSearchablePageResult<T> result) {
    super.onQuerySuccess(condition, result);
    if (condition.page == result.totalPage) {
      _pagingController.appendLastPage(result.datas);
    } else {
      _pagingController.appendPage(result.datas, condition.page + 1);
    }
  }

  void _toggle(T highlight) {
    final List<T> value = List.of(status.value);
    if (value.remove(highlight)) {
      super.value = value;
    } else {
      super.value = value..add(highlight);
    }
  }
}
