import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocrrub/src/view/common.dart';

class TextPreview extends StatefulWidget {
  static const String routeName = 'textpreviewroute';
  final InputImage? inputImage;

  const TextPreview({Key? key, this.inputImage}) : super(key: key);

  @override
  _TextPreviewState createState() => _TextPreviewState();
}

class _TextPreviewState extends State<TextPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    if (widget.inputImage?.bytes != null) {
      return Center(child: Image.memory(widget.inputImage!.bytes!));
    } else
      return Container();
  }
}
