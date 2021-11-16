import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_preview.dart';
import 'package:ocrrub/src/view/widgets/material_banner.dart';

import 'camera_view.dart';
import 'painters/object_detector_painter.dart';

class ObjectDetectorView extends StatefulWidget {
  static const String routeName = '/objectdetectorview';

  @override
  _ObjectDetectorView createState() => _ObjectDetectorView();
}

class _ObjectDetectorView extends State<ObjectDetectorView> {
  late ObjectDetector objectDetector;
  InputImage? currentInputImage;

  @override
  void initState() {
    objectDetector = GoogleMlKit.vision.objectDetector(ObjectDetectorOptions(
        classifyObjects: true, trackMutipleObjects: false));
    super.initState();
  }

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    objectDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraViewOld(
      title: 'Object Detector',
      customPaint: customPaint,
      onImage: processImage,
      initialDirection: CameraLensDirection.back,
    );
  }

  void takeImage() {
    if(currentInputImage != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => TextPreview(inputImage: currentInputImage,)));
    }
    else {
      showSnackbar(context, 'Please detect an Object.');
    }
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final result = await objectDetector.processImage(inputImage);
    customPaint = null;
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        result.length > 0) {
      currentInputImage = inputImage;
      final painter = ObjectDetectorPainter(
          result,
          inputImage.inputImageData!.imageRotation,
          inputImage.inputImageData!.size);
      customPaint = CustomPaint(painter: painter);
    } else {
      currentInputImage = null;
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
