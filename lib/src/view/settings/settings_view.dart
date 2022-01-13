import 'package:ocrrub/src/view/settings/settings_controller.dart';
import 'package:ocrrub/src/view/settings/widgets/add_to_samples_button.dart';
import 'package:ocrrub/src/view/settings/widgets/ocr_expected_text_settings.dart';

import '../common.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kPad,),
            OCRExpectedTextSettings(),
            SizedBox(height: kPad,),
            AddToSamplesButton(),
          ],
        )
      ),
    );
  }
}
