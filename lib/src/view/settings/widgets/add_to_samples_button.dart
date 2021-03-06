import 'dart:math';

import 'package:ocrrub/src/view/common.dart';
import 'package:ocrrub/src/view/ocr/ocr_controller.dart';
import 'package:ocrrub/src/view/settings/settings_controller.dart';
import 'package:ocrrub/src/view/widgets/scaffold_messenger.dart';

class AddToSamplesButton extends StatelessWidget {
  const AddToSamplesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _addToSamples(context),
      child: Text('Add current OCR'),
    );
  }

  /// Add the text that is currently recognized to the list of expected texts.
  /// This was mainly used for testing: A text was recognized using an image,
  /// added to the expected texts, and then used as the expected value for the
  /// test cases.
  Future<void> _addToSamples(BuildContext context) async {
    final controller = TextEditingController();
    final ocr = context.read<OCRController>().ocrText;
    if(ocr == null) {
      return showSnackbar('No OCR found');
    }
    controller.text = Random().nextInt(1000).toString();
    final name = await showDialog<String?>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add to expected texts'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter name'),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel', style: TextStyle(fontSize: 16))
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(controller.text),
                child: Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ),
          ],
        ),
    );
    if(name != null){
      context.read<SettingsController>().addToExpectedTexts(name, ocr);
    }
  }
}
