import 'dart:developer';

import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:string_similarity/string_similarity.dart';

import '../settings/settings_controller.dart';
import 'ocr_controller.dart';

class DiffPrinter {

  void writeDiff(BuildContext context) async {
    final oldText = context.read<SettingsController>().expectedOCR;
    final newText = context.read<OCRController>().ocrText;
    final blocks = context.read<OCRController>().recognisedText?.blocks.length;

    final comparison = oldText?.similarityTo(newText).toStringAsFixed(5);
    final recognized = recognizedChars(oldText, newText);

    print('Soer    | recognized | total | blocks');
    print('$comparison   $recognized        ${oldText?.length}     $blocks');

    log('$comparison\n$recognized\n${oldText?.length}\n$blocks');
  }

  int recognizedChars(String? oldText, String? newText) {
    int recognizedChars = 0;
    for(var diff in diff(oldText ?? '', newText ?? '')) {
      if(diff.operation == 0) {
        recognizedChars += diff.text.length;
      }
    }
    return recognizedChars;
  }
}