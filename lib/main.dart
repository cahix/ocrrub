import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'src/view/app.dart';
import 'src/view/settings/settings_controller.dart';
import 'src/view/settings/settings_service.dart';

List<CameraDescription> cameras = [];

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('CameraError: ${e.description}');
  }

  runApp(MyApp(settingsController: settingsController));
}
