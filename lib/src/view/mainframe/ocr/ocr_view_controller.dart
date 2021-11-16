import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/mainframe/ocr/my_painter.dart';
import 'package:ocrrub/src/view/widgets/material_banner.dart';
import 'package:ocrrub/src/view/widgets/smart_change_notifier.dart';

class OCRViewController extends SmartChangeNotifier {
  bool isBusy = false;
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  String? currentImagePath;
  CustomPainter? customPainter;

  Future<void> startOCR() async {
    if (isBusy) return;
    if (currentImagePath == null) return;
    isBusy = true;
    final inputImage = InputImage.fromFilePath(currentImagePath!);
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
      customPainter = null;
    }
  }

  void _setPaint(RecognisedText recognisedText) async {
    if(currentImagePath == null) return;
    Completer<ui.Image> completer = new Completer<ui.Image>();
    Image.file(File(currentImagePath!),).image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    final newImg = await completer.future;
    customPainter = MyPainter(
        recognisedText,
        Size(newImg.width.toDouble(), newImg.height.toDouble()),);
    notifyListeners();
  }

  Future<void> getImage(BuildContext context) async {
    try {
      currentImagePath = await EdgeDetection.detectEdge;
      print("$currentImagePath");
    } on PlatformException catch (e) {
      showSnackbar(e.toString());
      currentImagePath = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }
}