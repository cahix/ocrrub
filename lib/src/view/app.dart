import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ocrrub/main.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/object_detector_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_blocker_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_detector_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit2/rectangle_detector.dart';
import 'package:ocrrub/src/view/mainframe/ocr/ocr_view.dart';
import 'package:ocrrub/src/view/mainframe/ocr/ocr_view_controller.dart';

import '../view/mainframe/menu_item_list_view.dart';
import '../view/settings/settings_controller.dart';
import '../view/settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<OCRViewController>(
              create: (_) => OCRViewController(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case TextDetectorView.routeName:
                      return TextDetectorView();
                    case TextBlockerView.routeName:
                      return TextBlockerView();
                    case ObjectDetectorView.routeName:
                      return ObjectDetectorView();
                    case RectangleDetector.routeName:
                      return RectangleDetector();
                    case OCRView.routeName:
                      return OCRView();
                    case MenuItemListView.routeName:
                    default:
                      return const MenuItemListView();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
