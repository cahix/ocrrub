import 'dart:math';
import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';

class NormedTextLine {
  TextLine textLine;
  List<Offset> normalCornerPoints;

  NormedTextLine(this.textLine, this.normalCornerPoints);
}


List<NormedTextLine> getNormalLines(List<TextLine> lines) {
  double maxX = 1.0;
  double maxY = 1.0;

  for(var line in lines) {
    final topRight = line.cornerPoints[1];
    final bottomLeft = line.cornerPoints[2];
    final bottomRight = line.cornerPoints[3];
    maxX = max(maxX, max(topRight.dx, bottomRight.dx));
    maxY = max(maxY, max(bottomLeft.dy, bottomRight.dy));
  }

  print("maxX : $maxX");
  print("maxY : $maxY");

  List<NormedTextLine> res = [];
  for(var line in lines) {
    res.add(NormedTextLine(line, normCornerPoints(line.cornerPoints, maxX, maxY)));
  }
  res.forEach((e) {print(e.textLine.cornerPoints[0].toString() + " " + e.normalCornerPoints[0].toString());});
  return res;
}

List<Offset> normCornerPoints(List<Offset> offsets, double maxX, double maxY) {
  return [
    Offset(offsets[0].dx / maxX, offsets[0].dy / maxY),
    Offset(offsets[1].dx / maxX, offsets[1].dy / maxY),
    Offset(offsets[2].dx / maxX, offsets[2].dy / maxY),
    Offset(offsets[3].dx / maxX, offsets[3].dy / maxY)
  ];
}

List<TextLine> sortByOffset(List<NormedTextLine> lines) {
  final List<NormedTextLine> sorted = lines..sort((a, b) {
    final topLeft1 = a.normalCornerPoints[0];
    final topLeft2 = b.normalCornerPoints[0];
    int compY = compareToWithTolerance(topLeft1.dy, topLeft2.dy, 10.0);
    if (compY != 0) return compY;
    return topLeft1.dx.compareTo(topLeft2.dx);
  });
  return List.from(sorted.map((e) => e.textLine));
}

int compareToWithTolerance(double a, double b, double tolerance) {
  return ((a - b).abs() < tolerance) ? 0 : a.compareTo(b);
}
