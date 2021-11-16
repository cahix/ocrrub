import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/mainframe/ocr/image_view.dart';
import 'package:ocrrub/src/view/mainframe/ocr/ocr_view_controller.dart';
import 'package:ocrrub/src/view/widgets/provider_view.dart';
import 'package:provider/src/provider.dart';


class OCRViewBuilder extends StatelessWidget {
  const OCRViewBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderView<OCRViewController>(
        provider: OCRViewController(),
        child: OCRView(),
    );
  }
}

class OCRView extends StatefulWidget {
  static const String routeName = '/ocrview';

  @override
  _OCRViewState createState() => _OCRViewState();
}

class _OCRViewState extends State<OCRView> {
  late OCRViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<OCRViewController>();
    _controller.getImage(context);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<OCRViewController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('OCR'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _scanButton(),
                    _ocrButton(),
                  ],
                ),
                SizedBox(height: 16),
                ImageView(
                  imagePath: _controller.imagePath,
                  customPainter: _controller.customPainter,
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _scanButton() {
    return ElevatedButton(
      onPressed: () => _controller.getImage(context),
      child: Text('Scan'),
    );
  }

  Widget _ocrButton() {
    return Visibility(
      visible: _controller.imagePath != null,
      child: ElevatedButton(
        onPressed: () => _controller.startOCR(),
        child: Text('OCR'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}