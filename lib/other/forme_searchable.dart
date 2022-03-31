import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/field/material/forme_switch.dart';
import 'package:forme_base_fields/field/material/forme_text_field.dart';
import 'package:forme_searchable/forme_searchable.dart';

import '../example.dart';
import '../forme_screen.dart';
import 'package:http/http.dart' as http;

class FormeSearchableScreen extends FormeScreen {
  static Future<List<Todo>> fetchTodos(FormeSearchCondition condition) async {
    final String? query = condition.getCondition('query');
    final bool completed = condition.getCondition('completed') ?? false;
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
            title: 'FormeRatingBar',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.bottomSheet(
                    name: 'bottomSheet',
                    queryFilter: (condition) {
                      final String? query = condition.getCondition('query');
                      return query != null && query.isNotEmpty;
                    },
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
                    queryFilter: (condition) {
                      final String? query = condition.getCondition('query');
                      return query != null && query.isNotEmpty;
                    },
                    query: (condition) {
                      return Future.delayed(const Duration(seconds: 2), () {
                        return FormeSearchablePageResult<String>(
                            List.generate(50, (index) => '$index'), 2);
                      });
                    },
                  ),
                  subTitle: 'Example2',
                  title: 'Dialog',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<String>.dialog(
                    name: 'searchFields',
                    queryFilter: (condition) {
                      final String? query = condition.getCondition('query');
                      return query != null && query.isNotEmpty;
                    },
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
                    searchFieldsBuilder: (context, query, key) {
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
                              decoration:
                                  const InputDecoration(labelText: 'search'),
                            )),
                            FormeSwitch(name: 'caseSensitive')
                          ]),
                        ),
                      );
                    },
                  ),
                  title: 'Customize search fields',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<Todo>.bottomSheet(
                    name: 'display',
                    queryFilter: (condition) {
                      final String? query = condition.getCondition('query');
                      return query != null && query.isNotEmpty;
                    },
                    query: (condition) async {
                      final List<Todo> todos = await fetchTodos(condition);
                      return FormeSearchablePageResult(todos, 1);
                    },
                    displayStringForOption: (todo) => todo.title,
                    optionWidgetBuilder: (context, todo, isSelected) {
                      return ListTile(
                        trailing: todo.isCompleted
                            ? const Text(
                                'completed',
                                style: TextStyle(color: Colors.greenAccent),
                              )
                            : null,
                        title: Text(todo.title),
                        leading: isSelected ? const Icon(Icons.check) : null,
                      );
                    },
                    searchFieldsBuilder: (context, query, key) {
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
                              autofocus: true,
                              name: 'query',
                              decoration:
                                  const InputDecoration(labelText: 'search'),
                            )),
                            FormeSwitch(name: 'completed')
                          ]),
                        ),
                      );
                    },
                  ),
                  title: 'Custom display',
                ),
                Example(
                  formeKey: key,
                  field: FormeSearchable<Todo>.dialog(
                    maximum: 1,
                    name: 'single',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (state, value) {
                      return value.isEmpty ? 'pls select' : null;
                    },
                    dialogConfiguration:
                        FormeDialogConfiguration(sizeProvider: (context, data) {
                      return Size(
                          data.size.width * 0.8, data.size.height * 0.8);
                    }),
                    queryFilter: (condition) {
                      final String? query = condition.getCondition('query');
                      return query != null && query.isNotEmpty;
                    },
                    query: (condition) async {
                      final List<Todo> todos = await fetchTodos(condition);
                      return FormeSearchablePageResult(todos, 1);
                    },
                    displayStringForOption: (todo) => todo.title,
                  ),
                  title: 'Single select',
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
