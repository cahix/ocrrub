import 'dart:async';

import 'package:edge_detection/edge_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/misc/helper_functions.dart';
import 'package:ocrrub/src/view/ocr/ocr_noramaliser.dart';
import 'package:ocrrub/src/view/widgets/scaffold_messenger.dart';
import 'package:ocrrub/src/view/widgets/smart_change_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'widgets/my_painter.dart';

class OCRController extends SmartChangeNotifier {
  ScreenshotController screenshotController = ScreenshotController();
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  PageController pageController = PageController();
  String? currentImagePath;
  CustomPainter? customPainter;
  String? ocrText;
  bool isScanning = false;
  OCRNormaliser _ocrNormaliser = OCRNormaliser();

  bool hasImage() => currentImagePath != null;

  void reset() {
    currentImagePath = null;
    customPainter = null;
    ocrText = null;
    notifyListeners();
  }

  Future<void> scan({bool fromStorage = false}) async {
    isScanning = true;
    reset();
    if(fromStorage) {
      await _getImageFromStorage();
    }
    else {
      await _getImageFromEdgeDetection();
    }
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
    final norm = _ocrNormaliser.normalize(recognisedText);
    final blocks = recognisedText.blocks;
    print('Blocks:  ${blocks.length}');
    if (blocks.length > 0) {
      _setPaint(recognisedText);
     // ocrText = recognisedText.text.replaceAll("\n", ' ');
      for (var n in norm) {
        print(n.text + " " + n.cornerPoints[0].toString());
      }
      ocrText = getTextFromLines(norm);
    } else {
      showSnackbar('No text recognized');
      customPainter = null;
    }
  }

  String getTextFromLines(List<TextLine> lines) {
    String res = '';
    for(var line in lines) {
      res += line.text + " ";
    }
    return res.substring(0, res.length - 1);
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

  Future<void> _getImageFromEdgeDetection() async {
    try {
      currentImagePath = await EdgeDetection.detectEdge;
      print("$currentImagePath");
    } on PlatformException catch (e) {
      showSnackbar(e.toString());
      currentImagePath = null;
    }
  }

  Future<void> _getImageFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      currentImagePath = result.files.first.path;
    }
  }

  Future<void> takeScreenshot() async {
    final dir = (await getExternalStorageDirectories())?.first;
    if (dir != null) {
      screenshotController.captureAndSave(dir.path)
          .then((value) => showSnackbar('Saved'));
    } else {
      showSnackbar('Cannot save file');
    }
  }

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }
}
