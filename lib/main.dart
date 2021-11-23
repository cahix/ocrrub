import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/global_providers.dart';

import 'src/view/app.dart';

List<CameraDescription> cameras = [];
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('CameraError: ${e.description}');
  }

  runApp(GlobalProviders(child: MyApp()));
}
