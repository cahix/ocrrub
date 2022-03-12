import 'package:google_ml_kit/google_ml_kit.dart';

/// Normalize the recognized text (which is the output of the OCR algorithm).
/// Order the recognized lines by their coordinates, so the output does not vary
/// depending on the size of the blocks that have been recognized.

class OCRNormaliser {
  List<TextLine> normalize(RecognisedText recognisedText) {
    List<TextLine> lines = [];
    for(var block in recognisedText.blocks) {
      for(var line in block.lines) {
        lines.add(line);
      }
    }
    return sortByOffset(lines);
  }

  List<TextLine> sortByOffset(List<TextLine> lines) {
    return lines..sort((a, b) {
      final topLeft1 = a.cornerPoints[0];
      final topLeft2 = b.cornerPoints[0];
      int compY = compareToWithTolerance(topLeft1.dy, topLeft2.dy, 10.0);
      if (compY != 0) return compY;
      return topLeft1.dx.compareTo(topLeft2.dx);
    });
  }

  int compareToWithTolerance(double a, double b, double tolerance) {
    return ((a - b).abs() < tolerance) ? 0 : a.compareTo(b);
  }
}