import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/mainframe/mlkit2/camera_view_controller.dart';
import 'package:ocrrub/src/view/mainframe/mlkit2/image_preview.dart';
import 'package:ocrrub/src/view/widgets/material_banner.dart';

import 'camera_view.dart';
import 'converter.dart';
import 'painters/object_detector_painter.dart';


class RectangleDetector extends StatefulWidget {
  static const String routeName = '/rectangledetectorroutename';

  @override
  _ObjectDetectorView createState() => _ObjectDetectorView();
}

class _ObjectDetectorView extends State<RectangleDetector> {
  late ObjectDetector objectDetector;
  InputImage? currentInputImage;
  DetectedObject? currentFirstResult;

  @override
  void initState() {
    objectDetector = GoogleMlKit.vision.objectDetector(ObjectDetectorOptions(
        classifyObjects: true, trackMutipleObjects: true));
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
    return ChangeNotifierProvider(
      create: (_) => CameraViewController(
          onImage: processImage,
          onTakeImage: onTakeImage,
      ),
      child: CameraView(
        title: 'Rectangle Detector',
        customPaint: customPaint,
        initialDirection: CameraLensDirection.back,
      ),
    );
  }

  Future<void> onTakeImage(CameraImage cameraImage) async {
    final image = await convertYUV420toImageColor(cameraImage);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ImagePreview(image: image, rect: currentFirstResult?.getBoundinBox(),)));
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
      currentFirstResult = result.first;
      final painter = ObjectDetectorPainter(
          [result.first],
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
