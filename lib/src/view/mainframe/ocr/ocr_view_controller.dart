import 'dart:async';
import 'dart:ui';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/mainframe/ocr/my_painter.dart';
import 'package:ocrrub/src/view/misc/helper_functions.dart';
import 'package:ocrrub/src/view/widgets/scaffold_messenger.dart';
import 'package:ocrrub/src/view/widgets/smart_change_notifier.dart';

class OCRViewController extends SmartChangeNotifier {
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  String? currentImagePath;
  CustomPainter? customPainter;

  Future<void> startOCR({String? expected}) async {
    if (currentImagePath == null) return;
    final inputImage = InputImage.fromFilePath(currentImagePath!);
    final recognisedText = await textDetector.processImage(inputImage);
    _onTextRecognised(recognisedText);
    if (recognisedText.blocks.length > 0) notifyListeners();
  }

  void _onTextRecognised(RecognisedText recognisedText, {String? expected}) {
    final blocks = recognisedText.blocks;
    print('Found ${recognisedText.blocks.length} textBlocks');
    if (blocks.length > 0) {
      _setPaint(recognisedText);
      if (expected != null) {
        showMaterialBannerTextDiff(expected, recognisedText.text);
      } else {
        String text = '';
        for (var block in blocks) {
          text += block.text + "\n";
        }
        showMaterialBannerText(text);
      }
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

  Future<void> getImage(BuildContext context) async {
    customPainter = null;
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
