import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import 'package:forme_demo/other/infinite_scroll_pagination_content.dart';
import 'package:forme_searchable/forme_searchable.dart';

import '../example.dart';
import '../forme_screen.dart';
import 'package:http/http.dart' as http;

class FormeSearchableScreen extends FormeScreen {
  static Future<List<Todo>> fetchTodos(FormeSearchCondition condition) async {
    final String? query = condition.getFilter('query');
    final bool completed = condition.getFilter('completed') ?? false;
    final http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => Todo.fromJson(e)).where((element) {
        if (element.isCompleted != completed) {
          return false;
        }
        if (query != null) {
          return element.title.contains(query);
        }
        return true;
      }).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  FormeSearchableScreen({Key? key})
      : super(
            key: key,
            title: 'FormeSearchable',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.base(
                    name: 'base',
                    query: (condition) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return FormeSearchablePageResult<String>(
                            List.generate(50, (index) => '$index'), 2);
                      });
                    },
                  ),
                  title: 'Base',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.overlay(
                    name: 'overlay',
                    query: (condition) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return FormeSearchablePageResult<String>(
                            List.generate(50, (index) => '$index'), 2);
                      });
                    },
                  ),
                  title: 'Overlay',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.bottomSheet(
                    name: 'bottomSheet',
                    query: (condition) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return FormeSearchablePageResult<String>(
                            List.generate(50, (index) => '$index'), 2);
                      });
                    },
                  ),
                  title: 'BottomSheet',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.dialog(
                    name: 'dialog',
                    dialogConfiguration:
                        FormeDialogConfiguration(sizeProvider: (context, data) {
                      return Size(
                          data.size.width * 0.8, data.size.height * 0.8);
                    }),
                    query: (condition) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return FormeSearchablePageResult<String>(
                            List.generate(50, (index) => '$index'), 2);
                      });
                    },
                  ),
                  title: 'Dialog',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<Todo>.dialog(
                    name: 'searchFields',
                    queryFilter: (condition) {
                      final String? query = condition.getFilter('query');
                      return query != null && query.isNotEmpty;
                    },
                    optionWidgetBuilder: (context, todo, isSelected) {
                      return ListTile(
                        title: Text(todo.title),
                        leading: isSelected ? const Icon(Icons.check) : null,
                        trailing:
                            todo.isCompleted ? const Text('completed') : null,
                      );
                    },
                    displayStringForOption: (todo) => todo.title,
                    dialogConfiguration:
                        FormeDialogConfiguration(sizeProvider: (context, data) {
                      return Size(
                          data.size.width * 0.8, data.size.height * 0.8);
                    }),
                    query: (condition) async {
                      final List<Todo> todos = await fetchTodos(condition);
                      return FormeSearchablePageResult(todos, 1);
                    },
                    searchFieldsBuilder: (context) {
                      return FormeSearchableSearchFields<Todo>(
                        builder: (key, context, query) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Forme(
                              onFieldStatusChanged: query == null
                                  ? null
                                  : (state, status) {
                                      if (status.isValueChanged) {
                                        query();
                                      }
                                    },
                              key: key,
                              child: Row(children: [
                                Expanded(
                                    child: FormeTextField(
                                  name: 'query',
                                  decoration: const InputDecoration(
                                      labelText: 'search'),
                                )),
                                FormeSwitch(name: 'completed')
                              ]),
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
                  field: FormeSearchable<Todo>.base(
                    maximum: 1,
                    name: 'single',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (state, value) {
                      return value.isEmpty ? 'pls select' : null;
                    },
                    query: (condition) async {
                      final List<Todo> todos = await fetchTodos(condition);
                      return FormeSearchablePageResult(todos, 1);
                    },
                    displayStringForOption: (todo) => todo.title,
                  ),
                  title: 'Single select',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<Todo>.base(
                    maximum: 1,
                    name: 'filter',
                    decoration: const InputDecoration(labelText: '123'),
                    query: (condition) async {
                      final List<Todo> todos = await fetchTodos(condition);
                      return FormeSearchablePageResult(todos, 1);
                    },
                    queryFilter: (condition) {
                      final String? query = condition.getFilter('query');
                      return query != null && query.isNotEmpty;
                    },
                    displayStringForOption: (todo) => todo.title,
                  ),
                  subTitle: 'prevent query when text field is empty',
                  title: 'Query Filter',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.dialog(
                    dialogConfiguration: FormeDialogConfiguration(
                        performSearchAfterOpen: false,
                        sizeProvider: (context, data) {
                          return Size(
                              data.size.width * 0.8, data.size.height * 0.8);
                        }),
                    name: 'infinite',
                    decoration: const InputDecoration(labelText: 'infinite'),
                    query: (condition) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return FormeSearchablePageResult<String>(
                            List.generate(20,
                                (index) => '${20 * condition.page + index}'),
                            10);
                      });
                    },
                    queryFilter: (condition) {
                      final String? query = condition.getFilter('query');
                      return query != null && query.isNotEmpty;
                    },
                    paginationBarBuilder: (context) => const SizedBox(),
                    contentBuilder: (context) {
                      return const InfiniteScrollPaginationContentView<
                          String>();
                    },
                  ),
                  title: 'Infinite pagination scroll',
                ),
              ];
            });
}

class Todo {
  final int id;
  final String title;
  final bool isCompleted;

  Todo._({required this.id, required this.title, required this.isCompleted});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo._(
      id: json['id'],
      title: json['title'],
      isCompleted: json['completed'],
    );
  }
}
