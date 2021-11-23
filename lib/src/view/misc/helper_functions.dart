import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

Future<ui.Image> getImageFromPath(String path) async {
  Completer<ui.Image> _completer = new Completer<ui.Image>();
  Image.file(
    File(path),
  )
      .image
      .resolve(new ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    _completer.complete(info.image);
  }));
  return _completer.future;
}
