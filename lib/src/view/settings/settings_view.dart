import 'package:ocrrub/src/view/ocr/expected_texts.dart';

import '../common.dart';
import 'settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SettingsController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = context.read<SettingsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPad),
        child: Column(
          children: [
            SizedBox(height: kPad,),
            _ocrTextSettings(),
          ],
        )
      ),
    );
  }

  Widget _ocrTextSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expected Text', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
        SizedBox(height: 4,),
        DropdownButton<String?>(
          value: _controller.expectedOCR,
          onChanged: (value) => setState(() { _controller.expectedOCR = value; }),
          items: const [
            DropdownMenuItem(
              value: null,
              child: Text('- None -',),
            ),
            DropdownMenuItem(
              value: loremIpsum100,
              child: Text('Lorem Ipsum (100 words)'),
            ),
            DropdownMenuItem(
              value: kafka75,
              child: Text('Kafka (75 words)'),
            ),
            DropdownMenuItem(
              value: liEuropanLingues150,
              child: Text('Li Europan lingues (150 words)'),
            ),
          ],
        ),
      ],
    );
  }
}
