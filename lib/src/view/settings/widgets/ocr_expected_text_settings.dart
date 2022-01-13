import 'package:ocrrub/src/view/ocr/expected_texts.dart';

import '../../common.dart';
import '../settings_controller.dart';

class OCRExpectedTextSettings extends StatefulWidget {
  const OCRExpectedTextSettings({Key? key}) : super(key: key);

  @override
  _OCRExpectedTextSettingsState createState() => _OCRExpectedTextSettingsState();
}

class _OCRExpectedTextSettingsState extends State<OCRExpectedTextSettings> {
  @override
  Widget build(BuildContext context) {
    final _controller = context.read<SettingsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Expected Text', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
        SizedBox(height: 4,),
        DropdownButton<String?>(
          value: _controller.expectedOCR,
          onChanged: (value) => setState(() {
            _controller.expectedOCR = value;
          }),
          items: getItems()
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getItems() {
    List<DropdownMenuItem<String>> res = [];
    expectedTexts.forEach((key, value) {res.add(DropdownMenuItem(child: Text(key), value: value,));});
    return res;
  }
}
