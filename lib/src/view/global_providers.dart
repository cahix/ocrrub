
import 'package:ocrrub/src/view/settings/settings_controller.dart';

import 'common.dart';
import 'ocr/ocr_controller.dart';

class GlobalProviders extends StatelessWidget {
  final Widget child;

  const GlobalProviders({
    Key? key,
    required this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsController>(
          create: (_) => SettingsController(),
        ),
        ChangeNotifierProvider<OCRController>(
          create: (_) => OCRController(),
        ),
      ],
      child: child,
    );
  }
}
