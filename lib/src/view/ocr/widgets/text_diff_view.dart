
import 'package:ocrrub/src/view/ocr/ocr_controller.dart';
import 'package:ocrrub/src/view/ocr/widgets/legend.dart';
import 'package:ocrrub/src/view/settings/settings_controller.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

import '../../common.dart';
import '../diff_printer.dart';

class TextDiffView extends StatelessWidget {
  const TextDiffView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: kPad, right: kPad, top: kPad, bottom: 80),
        child: Column(
          children: [
            SizedBox(height: 4,),
            _legend(context),
            SizedBox(height: kPad,),
            _buildDiff(context),
          ],
        ),
      ),
    );
  }

  static const Color matchColor = Colors.greenAccent;
  static const Color addedColor = Colors.orangeAccent;
  static const Color deletedColor = Colors.redAccent;

  Widget _legend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const LegendItem(color: matchColor, name: 'Expected'),
        const LegendItem(color: addedColor, name: 'New'),
        const LegendItem(color: deletedColor, name: 'Missing'),
      ],
    );
  }

  Widget _buildDiff(BuildContext context) {
    final oldText = context.read<SettingsController>().expectedOCR;
    final newText = context.read<OCRController>().ocrText;
    DiffPrinter().printDiff(context);
    if(newText == null) {
      return Text('No text found');
    } else if (oldText == null) {
      return Text(newText);
    } else {
      return PrettyDiffText(
        defaultTextStyle: TextStyle(color: matchColor),
        addedTextStyle: TextStyle(color: Colors.white, backgroundColor: addedColor),
        deletedTextStyle: TextStyle(color: Colors.white, backgroundColor: deletedColor),
        oldText: oldText,
        newText: newText,
      );
    }
  }
}
