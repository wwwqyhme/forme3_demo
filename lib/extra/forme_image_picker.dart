import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme_fields/forme_fields.dart';

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
                    draggableConfiguration:
                        DraggableConfiguration<FormeImage>(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images4',
                  ),
                  title: 'FormeImagePicker4',
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
