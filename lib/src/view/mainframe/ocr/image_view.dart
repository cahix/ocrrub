
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ocrrub/src/view/widgets/emty_widget.dart';

class ImageView extends StatelessWidget {
  final String? imagePath;
  final CustomPaint? customPaint;

  const ImageView({
    Key? key,
    this.imagePath,
    this.customPaint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(imagePath == null) return const Empty();
    print(Image.file(
      File(imagePath ?? ''),
    ));
    return Stack(
      //fit: StackFit.expand,
      children: [
        Image.file(
          File(imagePath ?? ''),
        ),
        customPaint ?? const Empty(),
      ],
    );
  }
}
