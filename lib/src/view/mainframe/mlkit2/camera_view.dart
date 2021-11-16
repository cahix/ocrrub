import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocrrub/src/view/mainframe/mlkit2/camera_view_controller.dart';
import 'package:provider/src/provider.dart';

import '../../../../main.dart';

class CameraView extends StatefulWidget {
  final String title;
  final CustomPaint? customPaint;
  final CameraLensDirection initialDirection;

  const CameraView({
    Key? key,
    required this.title,
    required this.customPaint,
    this.initialDirection = CameraLensDirection.back
  }) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraViewController _controller;

  @override
  void initState() {
    _controller = context.read<CameraViewController>();
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        _controller.cameraIndex = i;
      }
    }
    _controller.startLiveFeed();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<CameraViewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          //_switchScreenModeSetting(),
        ],
      ),
      body: _liveFeedBody(),
      floatingActionButton: _takeImageButton(),
    );
  }

  Widget? _takeImageButton() {
    if (cameras.length == 1) return null;
    return Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: Icon(
            Icons.camera,
            size: 40,
          ),
          onPressed: () => _controller.takeCameraImage(),
        ));
  }

  Widget _liveFeedBody() {
    if (_controller.cameraController?.value.isInitialized == false) {
      return Container();
    }
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_controller.cameraController!),
          if (widget.customPaint != null) widget.customPaint!,
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: _zoomSlider(),
          )
        ],
      ),
    );
  }

  Widget _zoomSlider() {
    return Slider(
      value: _controller.zoomLevel,
      min: _controller.minZoomLevel,
      max: _controller.maxZoomLevel,
      onChanged: (newSliderValue) {
        setState(() {
          _controller.zoomLevel = newSliderValue;
          _controller.cameraController!.setZoomLevel(_controller.zoomLevel);
        });
      },
      divisions: (_controller.maxZoomLevel - 1).toInt() < 1
          ? null
          : (_controller.maxZoomLevel - 1).toInt(),
    );
  }
}
