import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/ocr/ocr_view_controller.dart';
import 'package:ocrrub/src/view/settings/settings_controller.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

import '../common.dart';

class TextDiffView extends StatelessWidget {
  const TextDiffView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: kPad, right: kPad, top: kPad, bottom: 70),
        child: _buildDiff(context),
      ),
    );
  }

  Widget _buildDiff(BuildContext context) {
    final oldText = context.read<SettingsController>().expectedOCR;
    final newText = context.read<OCRViewController>().ocrText;
    print(oldText);
    print("-");
    print(newText);
    if(newText == null) {
      return Text('No text found');
    } else if (oldText == null) {
      return Text(newText);
    } else {
      return PrettyDiffText(
        defaultTextStyle: TextStyle(color: Colors.white),
        oldText: oldText,
        newText: newText,
      );
    }
  }
}
