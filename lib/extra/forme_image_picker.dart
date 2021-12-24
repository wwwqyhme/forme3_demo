import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';
import 'package:forme_file_picker/forme_file_picker.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeImagePickerScreen extends FormeScreen {
  FormeImagePickerScreen({Key? key})
      : super(
            key: key,
            title: 'FormeImagePicker',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  name: 'images1',
                  field: FormeImagePicker(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images1',
                  ),
                  title: 'FormeImagePicker',
                ),
                Example(
                  subTitle:
                      'camera support (not all service suppot capture with camera , default is false)',
                  formeKey: key,
                  name: 'images2',
                  field: FormeImagePicker(
                    supportCamera: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images2',
                  ),
                  title: 'FormeImagePicker2',
                ),
                Example(
                  subTitle: 'drag & sort (long press on image to start drag)',
                  formeKey: key,
                  name: 'images3',
                  field: FormeImagePicker(
                    draggableConfiguration:
                        DraggableConfiguration<FormeImage>(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images3',
                  ),
                  title: 'FormeImagePicker3',
                ),
                Example(
                  subTitle: 'display  network images',
                  formeKey: key,
                  name: 'images4',
                  field: FormeImagePicker(
                    initialValue: [
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/a.jpg'),
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/b.png'),
                    ],
                    draggableConfiguration:
                        DraggableConfiguration<FormeImage>(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images4',
                  ),
                  title: 'FormeImagePicker4',
                ),
                Example(
                  subTitle: 'delete files with drag!',
                  formeKey: key,
                  name: 'images5',
                  field: FormeImagePicker(
                    showGridItemRemoveIcon: false,
                    onDragCompleted: (field, index) {
                      field.remove(index);
                    },
                    decorator: FormeInputDecoratorBuilder(
                        decoration: const InputDecoration(labelText: 'Images'),
                        wrapper: (child, field) {
                          return Column(
                            children: [
                              child,
                              const SizedBox(
                                height: 10,
                              ),
                              ValueListenableBuilder<bool>(
                                  valueListenable:
                                      (field as FormeImagePickerFieldController)
                                          .draggingListenable,
                                  builder: (context, dragging, child) {
                                    if (dragging) {
                                      return DragTarget(onWillAccept: (data) {
                                        return field.canAccept(data);
                                      }, builder: (context, a, b) {
                                        return Container(
                                          height: 100,
                                          color:
                                              Colors.redAccent.withOpacity(0.8),
                                          child: Center(
                                            child: a.isEmpty
                                                ? const Text(
                                                    'drop here to remove')
                                                : const Text(
                                                    'release to remove'),
                                          ),
                                        );
                                      });
                                    }
                                    return const SizedBox.shrink();
                                  }),
                            ],
                          );
                        }),
                    draggableConfiguration:
                        DraggableConfiguration<FormeImage>(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    name: 'images5',
                  ),
                  title: 'FormeImagePicker5',
                ),
              ];
            });
}

class _NImage extends FormeImage {
  final String url;

  _NImage(this.url);
  @override
  Future<ImageProvider<Object>> get image async {
    return NetworkImage(url);
  }

  @override
  String? get name => throw UnimplementedError();

  @override
  Future<Uint8List?> readAsBytes() {
    throw UnimplementedError();
  }
}
