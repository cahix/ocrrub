
import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/global_providers.dart';

import 'src/view/app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GlobalProviders(child: MyApp()));
}
