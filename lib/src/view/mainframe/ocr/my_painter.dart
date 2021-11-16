import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MyPainter extends CustomPainter {
  MyPainter(this.recognisedText, this.absoluteImageSize);

  final RecognisedText recognisedText;
  final Size absoluteImageSize;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;
    Rect scaleRect(TextBlock block) {
      return Rect.fromLTRB(
        block.rect.left * scaleX,
        block.rect.top* scaleY,
        block.rect.right * scaleX,
        block.rect.bottom* scaleY,
      );
    }
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blueAccent
      ..strokeWidth = 1.0;
    for (var block in recognisedText.blocks) {
      canvas.drawRect(scaleRect(block), paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.recognisedText != recognisedText;
  }
}