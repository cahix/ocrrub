import 'package:ocrrub/src/view/settings/widgets/ocr_expected_text_settings.dart';

import '../common.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPad),
        child: Column(
          children: [
            SizedBox(height: kPad,),
            OCRExpectedTextSettings(),
          ],
        )
      ),
    );
  }
}
