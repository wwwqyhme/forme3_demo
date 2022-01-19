import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_searchable/forme_searchable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FormeSearchableContent2<T extends Object>
    extends FormeSearchableContent<T> {
  const FormeSearchableContent2({
    Key? key,
  }) : super(key: key);

  @override
  FormeSearchableContentState<T> createState() =>
      _FormeSearchableContent2State<T>();
}

class _FormeSearchableContent2State<T extends Object>
    extends FormeSearchableContentState<T> {
  late final PagingController<int, T> _pagingController;

  void _query(int page) {
    final Map<String, dynamic> condition = {'query': '1'};
    searchable.query(condition, page);
  }

  @override
  void initState() {
    _pagingController = PagingController<int, T>(
      firstPageKey: 1,
    );
    _pagingController.addPageRequestListener((pageKey) {
      _query(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: Material(
        child: PagedListView.separated(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: (context, data, index) => InkWell(
              child: ListTile(
                leading: searchable.contains(data) ? Text('checked') : null,
                title: Text('$data'),
              ),
              onTap: () {
                searchable.toggle(data);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onStateChanged(FormeAsyncOperationState state,
      FormeSearchablePageResult<T>? result, int? currentPage) {
    if (mounted) {
      if (state == FormeAsyncOperationState.success) {
        if (currentPage == result!.totalPage) {
          _pagingController.appendLastPage(result.datas);
        } else {
          _pagingController.appendPage(result.datas, currentPage! + 1);
        }
      }
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (mounted) {
      _pagingController.error = error;
    }
  }

  @override
  void onSelectedChanged(List<T> value) {
    setState(() {});
  }
}
