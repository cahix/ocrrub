
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocrrub/src/view/common.dart';

class ImagePreview extends StatefulWidget {
  static const String routeName = 'imagepreviewroute';

  final Image? image;
  final XFile? file;
  final Rect? rect;

  const ImagePreview({
    Key? key,
    this.image,
    this.file,
    this.rect,
  }) : super(key: key);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _imageView()),
    );
  }

  Widget _imageView() {
    return RotatedBox(quarterTurns: 1, child: widget.image,);
  }
}
