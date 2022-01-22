import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:ocrrub/src/view/ocr/ocr_view_controller.dart';
import 'package:ocrrub/src/view/ocr/widgets/legend.dart';
import 'package:ocrrub/src/view/settings/settings_controller.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../common.dart';

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
    final comparison = oldText.similarityTo(newText).toStringAsFixed(5);
    print('Comp: $comparison');
    printDiff(oldText, newText);
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

  void printDiff(String? s1, String? s2) {
    // final int expectedChars = s1?.length ?? 0;
    int recognizedChars = 0;
    final diffmatch = diff(s1 ?? '', s2 ?? '');
    for(var diff in diffmatch) {
      if(diff.operation == 0) {
        recognizedChars += diff.text.length;
      }
    }
    print('Recognized Char: $recognizedChars');
    print('Total Char: ${s2?.length}');
  }
}
