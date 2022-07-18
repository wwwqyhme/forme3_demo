import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_file_picker/forme_file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../example.dart';
import '../forme_screen.dart';

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class FormeFileGridScreen extends FormeScreen {
  FormeFileGridScreen({Key? key})
      : super(
            sourceCode: 'other/forme_file_grid',
            key: key,
            title: 'FormeFileGrid',
            builder: (context, key) {
              return [
                Example(
                  subTitle: 'default',
                  formeKey: key,
                  field: FormeFileGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images1',
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
                  ),
                  title: 'FormeFileGrid1',
                ),
                Example(
                  subTitle: 'display  network images',
                  formeKey: key,
                  field: FormeFileGrid(
                    initialValue: [
                      _NImage(
                          'https://media.npr.org/assets/img/2022/07/12/southern-ring-nebula-2-_custom-60c7d16d9c36f085646be2dad4585892c783952d-s2000-c85.webp'),
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/b.png'),
                    ],
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images2',
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
                  ),
                  title: 'FormeFileGrid2',
                ),
                Example(
                  subTitle: 'delete files with drag!',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
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
                                  valueListenable: (field as FormeFileGridState)
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
                    name: 'images3',
                  ),
                  title: 'FormeFileGrid3',
                ),
                Example(
                  subTitle: 'disable drag',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
                    draggable: (item, index) => false,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images4',
                  ),
                  title: 'FormeFileGrid4',
                ),
                Example(
                  subTitle: 'disable drag & remove first image',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
                    initialValue: [
                      _NImage(
                          'https://raw.githubusercontent.com/wwwqyhme/forme3_demo/main/image/a.jpg'),
                    ],
                    draggable: (item, index) => index != 0,
                    removable: (item, index) => index != 0,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images5',
                  ),
                  title: 'FormeFileGrid5',
                ),
                Example(
                  subTitle: 'validate? if you need',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
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
                    name: 'images6',
                  ),
                  title: 'FormeFileGrid6',
                ),
                Example(
                  subTitle: 'disable default picker',
                  formeKey: key,
                  field: FormeFileGrid(
                    shrinkWrap: true,
                    decorator: FormeInputDecoratorBuilder(
                      wrapper: (child, field) {
                        return Column(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  FormeFileGridState state =
                                      field as FormeFileGridState;
                                  _pick(state, 9, ImageSource.gallery);
                                },
                                icon: const Icon(Icons.file_copy)),
                            if (field.value.isNotEmpty) child,
                          ],
                        );
                      },
                    ),
                    disableFilePicker: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images7',
                    pickFiles: (state, max) =>
                        _pick(state, max, ImageSource.gallery),
                  ),
                  title: 'FormeFileGrid7',
                ),
                Example(
                  subTitle: 'uploadable file',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) => _pick(
                        state, max, ImageSource.gallery,
                        uploadable: true),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Pick Images'),
                    maximum: 9,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images8',
                  ),
                  title: 'FormeFileGrid8',
                ),
                Example(
                  subTitle: 'autoupload',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) => _pick(
                        state, max, ImageSource.gallery,
                        uploadable: true, autoUpload: true),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Pick Images'),
                    maximum: 9,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images9',
                  ),
                  title: 'FormeFileGrid9',
                ),
                Example(
                  subTitle: 'global upload control',
                  formeKey: key,
                  field: FormeFileGrid(
                    pickFiles: (state, max) {},
                    maximum: 1,
                    decorator: FormeInputDecoratorBuilder(
                      wrapper: (child, field) {
                        return Column(
                          children: [
                            Builder(builder: (context) {
                              return Row(children: [
                                IconButton(
                                  onPressed: () async {
                                    FormeFileGridState state =
                                        field as FormeFileGridState;
                                    _pick(state, 9, ImageSource.gallery,
                                        uploadable: true, autoUpload: false);
                                  },
                                  icon: const Icon(Icons.file_copy),
                                ),
                                if (field.value
                                    .where((element) => element.uploadable)
                                    .isNotEmpty)
                                  IconButton(
                                    onPressed: () async {
                                      (field as FormeFileGridState)
                                          .retryUpload();
                                      field.upload();
                                      (context as Element).markNeedsBuild();
                                    },
                                    icon: const Icon(Icons.upload),
                                  ),
                                if (field.value
                                    .where((element) => element.isUploading)
                                    .isNotEmpty)
                                  IconButton(
                                    onPressed: () async {
                                      (field as FormeFileGridState)
                                          .cancelUpload();
                                      (context as Element).markNeedsBuild();
                                    },
                                    icon: const Icon(Icons.cancel),
                                  ),
                              ]);
                            }),
                            if (field.value.isNotEmpty) child,
                          ],
                        );
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150),
                    name: 'images10',
                  ),
                  title: 'FormeFileGrid10',
                ),
              ];
            });
}

void _pick(
  FormeFileGridState state,
  int? max,
  ImageSource source, {
  bool uploadable = false,
  bool autoUpload = false,
}) async {
  _XFileFormeImage toXFileImage(XFile e) {
    if (uploadable) {
      if (autoUpload) {
        return _AutouploadXFileFormeImage(e);
      }
      return _UploadableXFileFormeImage(e);
    }
    return _XFileFormeImage(e);
  }

  final ImagePicker picker = ImagePicker();
  final List<FormeFile> images;
  if (max == 1 || source == ImageSource.camera) {
    XFile? xFile = await picker.pickImage(source: source);
    images = xFile == null ? [] : [toXFileImage(xFile)];
  } else {
    images = (await picker.pickMultiImage() ?? []).map((e) {
      return toXFileImage(e);
    }).toList();
  }
  state.insertFiles(images);
}

class _NImage extends FormeFile {
  final String url;

  _NImage(this.url);
  @override
  Future<ImageProvider<Object>> get thumbnail async {
    return NetworkImage(url);
  }
}

class _XFileFormeImage extends FormeFile {
  final XFile xFile;

  _XFileFormeImage(this.xFile);
  @override
  Future<ImageProvider<Object>> get thumbnail async {
    return Future.delayed(
        Duration.zero, () async => MemoryImage(await readAsBytes()));
  }

  Future<Uint8List> readAsBytes() => xFile.readAsBytes();
}

class _UploadableXFileFormeImage extends _XFileFormeImage {
  _UploadableXFileFormeImage(XFile xFile) : super(xFile);
  CloseableMultipartRequest? _request;
  HttpClient? client;
  @override
  bool get uploadable => true;
  @override
  Future upload() async {
    _request = CloseableMultipartRequest(
        "POST", Uri.parse("https://api.qyh.me/api/file"));
    _request!.files.add(http.MultipartFile.fromBytes(
      "file",
      await xFile.readAsBytes(),
      filename: "upload",
    ));
    Completer<String?> completer = Completer();
    try {
      http.StreamedResponse response = await _request!.send();
      if (response.statusCode == 200) {
        completer.complete(await response.stream.bytesToString());
      } else {
        completer.completeError('invalid status:${response.statusCode}');
      }
    } catch (e, trace) {
      completer.completeError(e, trace);
    }
    return completer.future;
  }

  @override
  void cancelUpload() {
    _request?.close();
  }
}

class _AutouploadXFileFormeImage extends _UploadableXFileFormeImage {
  _AutouploadXFileFormeImage(XFile xFile) : super(xFile);

  @override
  bool get autoUpload => true;
}

class CloseableMultipartRequest extends http.MultipartRequest {
  Client client = Client();

  CloseableMultipartRequest(String method, Uri uri) : super(method, uri);

  void close() => client.close();

  @override
  Future<http.StreamedResponse> send() async {
    try {
      var response = await client.send(this);
      var stream = onDone(response.stream, client.close);
      return http.StreamedResponse(
        http.ByteStream(stream),
        response.statusCode,
        contentLength: response.contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (_) {
      client.close();
      rethrow;
    }
  }

  Stream<T> onDone<T>(Stream<T> stream, void Function() onDone) =>
      stream.transform(StreamTransformer.fromHandlers(handleDone: (sink) {
        sink.close();
        onDone();
      }));
}
