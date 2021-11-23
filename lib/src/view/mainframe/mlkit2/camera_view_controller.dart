import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';

import '../../../../main.dart';

enum ScreenMode { liveFeed, gallery }

class CameraViewController with ChangeNotifier {
  CameraController? cameraController;
  int cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  CameraImage? currentImage;
  final Function(InputImage inputImage) onImage;
  final Function(CameraImage cameraImage) onTakeImage;

  CameraViewController({required this.onImage, required this.onTakeImage});

  Future<void> startLiveFeed() async {
    final camera = cameras[cameraIndex];
    cameraController = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    cameraController?.initialize().then((_) {
      cameraController?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      cameraController?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      cameraController?.startImageStream(_processCameraImage);
      notifyListeners();
    });
  }

  Future<void> stopLiveFeed() async {
    await cameraController?.stopImageStream();
    await cameraController?.dispose();
    cameraController = null;
  }

  void takeCameraImage() {
    if (currentImage == null) return;
    onTakeImage(currentImage!);
  }

  void _processCameraImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    onImage(inputImage);
    currentImage = image;
  }
}
