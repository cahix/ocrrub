import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ocrrub/main.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/global_providers.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/object_detector_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_blocker_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_detector_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit2/rectangle_detector.dart';
import 'package:ocrrub/src/view/ocr/page/ocr_view.dart';

import '../view/mainframe/menu_item_list_view.dart';
import 'settings/provider/settings_controller.dart';
import 'settings/page/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final settingsController = context.watch<SettingsController>();
        return MaterialApp(
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
                    return SettingsView();
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
        );
  }
}
