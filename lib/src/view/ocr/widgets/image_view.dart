import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ocrrub/src/view/settings/widgets/ocr_expected_text_settings.dart';
import 'package:ocrrub/src/view/widgets/emty_widget.dart';

class ImageView extends StatelessWidget {
  final String? imagePath;
  final CustomPainter? customPainter;

  const ImageView({Key? key, this.imagePath, this.customPainter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) return const Empty();
    return CustomPaint(
      foregroundPainter: customPainter,
      child: Image.file(
        File(imagePath ?? ''),
      ),
    );
  }
}
