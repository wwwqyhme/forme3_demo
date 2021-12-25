import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_file_picker/forme_file_picker.dart';

import '../exmaple.dart';
import '../forme_screen.dart';

class FormeImagePickerScreen extends FormeScreen {
  FormeImagePickerScreen({Key? key})
      : super(
            sourceCode: 'extra/forme_image_picker',
            key: key,
            title: 'FormeImagePicker',
            builder: (context, key) {
              return [
                Example(
                  subTitle: 'default',
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
                    draggable: (item, index) => false,
                    supportCamera: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images2',
                  ),
                  title: 'FormeImagePicker2',
                ),
                Example(
                  subTitle: 'display  network images',
                  formeKey: key,
                  name: 'images3',
                  field: FormeImagePicker(
                    initialValue: [
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/a.jpg'),
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/b.png'),
                    ],
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images3',
                  ),
                  title: 'FormeImagePicker3',
                ),
                Example(
                  subTitle: 'delete files with drag!',
                  formeKey: key,
                  name: 'images4',
                  field: FormeImagePicker(
                    showGridItemRemoveIcon: false,
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
                                      }, onAccept: (data) {
                                        field.removeData(data);
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
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    name: 'images4',
                  ),
                  title: 'FormeImagePicker4',
                ),
                Example(
                  subTitle: 'disable drag',
                  formeKey: key,
                  name: 'images5',
                  field: FormeImagePicker(
                    draggable: (item, index) => false,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images5',
                  ),
                  title: 'FormeImagePicker5',
                ),
                Example(
                  subTitle: 'disable drag & remove first image',
                  formeKey: key,
                  name: 'images6',
                  field: FormeImagePicker(
                    initialValue: [
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/a.jpg'),
                    ],
                    draggable: (item, index) => index != 0,
                    removable: (item, index) => index != 0,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images6',
                  ),
                  title: 'FormeImagePicker6',
                ),
                Example(
                  subTitle: 'validate? if you need',
                  formeKey: key,
                  name: 'images7',
                  field: FormeImagePicker(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Pick Images'),
                    validator: (field, value) {
                      if (value.length < 2) {
                        return 'you must pick at least 2 images';
                      }
                    },
                    maximum: 9,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images7',
                  ),
                  title: 'FormeImagePicker7',
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
