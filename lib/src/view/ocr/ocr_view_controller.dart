import 'dart:async';
import 'dart:ui';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/misc/helper_functions.dart';
import 'package:ocrrub/src/view/widgets/scaffold_messenger.dart';
import 'package:ocrrub/src/view/widgets/smart_change_notifier.dart';
import 'widgets/my_painter.dart';

class OCRViewController extends SmartChangeNotifier {
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  PageController pageController = PageController();
  String? currentImagePath;
  CustomPainter? customPainter;
  String? ocrText;
  bool isScanning = false;

  void reset() {
    currentImagePath = null;
    customPainter = null;
    ocrText = null;
    notifyListeners();
  }

  Future<void> scan() async {
    isScanning = true;
    reset();
    await _getImage();
    if(currentImagePath != null) {
      await _startOCR();
    }
    notifyListeners();
    if(ocrText != null) {
      _animateToTextDiffPage();
    }
    isScanning = false;
  }

  void _animateToTextDiffPage() {
    Future.delayed(Duration(milliseconds: 500)).then((value) =>
        pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 350),
            curve: Curves.fastOutSlowIn)
    );
  }

  Future<void> _startOCR() async {
    if (currentImagePath == null) return;
    final inputImage = InputImage.fromFilePath(currentImagePath!);
    final recognisedText = await textDetector.processImage(inputImage);
    _onTextRecognised(recognisedText);
  }

  void _onTextRecognised(RecognisedText recognisedText) {
    final blocks = recognisedText.blocks;
    if (blocks.length > 0) {
      _setPaint(recognisedText);
      ocrText = recognisedText.text.replaceAll("\n", ' ');
    } else {
      showSnackbar('No text recognized');
      customPainter = null;
    }
  }

  void _setPaint(RecognisedText recognisedText) async {
    if (currentImagePath == null) return;
    final newImg = await getImageFromPath(currentImagePath ?? '');
    customPainter = MyPainter(
      recognisedText,
      Size(newImg.width.toDouble(), newImg.height.toDouble()),
    );
    notifyListeners();
  }

  Future<void> _getImage() async {
    try {
      currentImagePath = await EdgeDetection.detectEdge;
      print("$currentImagePath");
    } on PlatformException catch (e) {
      showSnackbar(e.toString());
      currentImagePath = null;
    }
  }

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }
}
