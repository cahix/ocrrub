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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ocrTextSettings(),
          ],
        )
      ),
    );
  }

  Widget _ocrTextSettings() {
    return DropdownButton<String?>(
      value: _controller.expectedOCR,
      onChanged: (value) => setState(() { _controller.expectedOCR = value; }),
      items: const [
        DropdownMenuItem(
          value: loremIpsum100,
          child: Text('Lorem Ipsum (100 words)'),
        ),
        DropdownMenuItem(
          value: null,
          child: Text('None'),
        ),
      ],
    );
  }
}
