import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_file_picker/forme_file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../example.dart';
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
                  field: FormeImagePicker(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images1',
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
                  ),
                  title: 'FormeImagePicker',
                ),
                Example(
                  subTitle:
                      'camera support (not all service suppot capture with camera , default is false)',
                  formeKey: key,
                  field: FormeImagePicker(
                    draggable: (item, index) => false,
                    supportCamera: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images2',
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
                    pickFromCamera: (max) => _pick(max, ImageSource.camera),
                  ),
                  title: 'FormeImagePicker2',
                ),
                Example(
                  subTitle: 'display  network images',
                  formeKey: key,
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
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
                  ),
                  title: 'FormeImagePicker3',
                ),
                Example(
                  subTitle: 'delete files with drag!',
                  formeKey: key,
                  field: FormeImagePicker(
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
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
                                      (field as FormeImagePickerState)
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
                  field: FormeImagePicker(
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
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
                  field: FormeImagePicker(
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
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
                  field: FormeImagePicker(
                    pickFromGallery: (max) => _pick(max, ImageSource.gallery),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Pick Images'),
                    validator: (field, value) {
                      if (value.length < 2) {
                        return 'you must pick at least 2 images';
                      }
                      return null;
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

Future<List<FormeImage>> _pick(int? max, ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final List<FormeImage> images;
  if (max == 1 || source == ImageSource.camera) {
    XFile? xFile = await picker.pickImage(source: source);
    images = xFile == null ? [] : [_XFileFormeImage(xFile)];
  } else {
    images = (await picker.pickMultiImage() ?? [])
        .map((e) => _XFileFormeImage(e))
        .toList();
  }
  return images;
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
  Future<Uint8List>? readAsBytes() {
    throw UnimplementedError();
  }
}

class _XFileFormeImage extends FormeImage {
  final XFile xFile;

  _XFileFormeImage(this.xFile);
  @override
  Future<ImageProvider<Object>> get image async {
    return MemoryImage(await xFile.readAsBytes());
  }

  @override
  String? get name => xFile.name;

  @override
  Future<Uint8List>? readAsBytes() => xFile.readAsBytes();
}
