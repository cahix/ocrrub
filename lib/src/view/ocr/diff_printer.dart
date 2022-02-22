import 'dart:developer';

import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:ocrrub/src/view/common.dart';
import 'package:string_similarity/string_similarity.dart';

import '../settings/settings_controller.dart';
import 'ocr_controller.dart';

class DiffPrinter {
  void printDiff(BuildContext context) async {
    final oldText = context.read<SettingsController>().expectedOCR;
    final newText = context.read<OCRController>().ocrText;
    final blocks = context.read<OCRController>().recognisedText?.blocks.length;

    final comparison = oldText?.similarityTo(newText).toStringAsFixed(5);
    final recognized = recognizedChars(oldText, newText);
    final correct = recognized.val1;
    final errors = recognized.val2;

    log('Soer    | errors | correct | chars(original)  | chars(this)');
    log('$comparison   $errors        $correct      ${oldText?.length}              ${newText?.length}');
  }

  Tuple<int> recognizedChars(String? oldText, String? newText) {
    int recognizedChars = 0;
    int errors = 0;
    for(var diff in diff(oldText ?? '', newText ?? '')) {
      if(diff.operation == 0) {
        recognizedChars += diff.text.length;
      } else {
        errors++;
      }
    }
    return Tuple(recognizedChars, errors);
  }
}

class Tuple<T>{
  T? val1;
  T? val2;

  Tuple(this.val1, this.val2);
}