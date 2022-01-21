import 'package:google_ml_kit/google_ml_kit.dart';

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
      int compY = topLeft1.dy.compareTo(topLeft2.dy);
      if (compY != 0) return compY;
      return topLeft1.dx.compareTo(topLeft2.dx);
    });
  }
}