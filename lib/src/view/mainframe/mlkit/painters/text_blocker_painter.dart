import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'coordinates_translator.dart';

class TextBlockerPainter extends CustomPainter {
  TextBlockerPainter(
      this.recognisedText, this.absoluteImageSize, this.rotation);

  final RecognisedText recognisedText;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    for (final textBlock in recognisedText.blocks) {
      final left =
      translateX(textBlock.rect.left, rotation, size, absoluteImageSize);
      final top =
      translateY(textBlock.rect.top, rotation, size, absoluteImageSize);
      final right =
      translateX(textBlock.rect.right, rotation, size, absoluteImageSize);
      final bottom =
      translateY(textBlock.rect.bottom, rotation, size, absoluteImageSize);

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(TextBlockerPainter oldDelegate) {
    return oldDelegate.recognisedText != recognisedText;
  }
}
