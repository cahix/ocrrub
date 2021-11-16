
import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/painters/text_detector_painter.dart';
import 'package:ocrrub/src/view/widgets/material_banner.dart';

class OCRViewController with ChangeNotifier {
  bool isBusy = false;
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  String? imagePath;
  CustomPaint? customPaint;

  Future<void> startOCR() async {
    if (isBusy) return;
    if (imagePath == null) return;
    isBusy = true;
    final inputImage = InputImage.fromFilePath(imagePath!);
    final recognisedText = await textDetector.processImage(inputImage);
    _onTextRecognised(recognisedText);
    if(recognisedText.blocks.length > 0)
    isBusy = false;
    notifyListeners();
  }
  
  void _onTextRecognised(RecognisedText recognisedText) {
    final blocks = recognisedText.blocks;
    print('Found ${recognisedText.blocks.length} textBlocks');
    if(blocks.length > 0) {
      _setPaint(recognisedText);
      String text = '';
      for (var block in blocks) { text += block.text + "\n"; }
      showMaterialBannerForText(text);
    }
    else {
      customPaint = null;
    }
  }

  void _setPaint(RecognisedText recognisedText) {
    if(imagePath == null) return;
    final img = Image.file(File(imagePath!),);
    if(img.width == null || img.height == null) return;
    final painter = TextDetectorPainter(
        recognisedText,
        Size(img.width!, img.height!),
        InputImageRotation.Rotation_0deg);
    customPaint = CustomPaint(painter: painter);
  }

  Future<void> getImage(BuildContext context) async {
    try {
      imagePath = (await EdgeDetection.detectEdge);
      print("$imagePath");
    } on PlatformException catch (e) {
      showSnackbar(e.toString());
      imagePath = null;
    }
    notifyListeners();
  }
}