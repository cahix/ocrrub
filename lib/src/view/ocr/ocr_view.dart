
import 'package:ocrrub/src/view/ocr/text_diff_view.dart';
import 'package:ocrrub/src/view/ocr/widgets/image_view.dart';
import 'package:ocrrub/src/view/settings/settings_controller.dart';
import 'package:ocrrub/src/view/widgets/default_scaffold.dart';
import 'package:ocrrub/src/view/widgets/super_button.dart';

import '../common.dart';
import 'ocr_view_controller.dart';

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
    _controller.scan();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<OCRViewController>();
    return DefaultScaffold(
      title: 'OCR',
      body: _pageView(),
      floatingActionButton: _scanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _pageView() {
    return PageView(
      controller: _controller.pageController,
      children: [
        _imageView(),
        if(_controller.ocrText != null) TextDiffView(),
      ],
    );
  }

  Widget _imageView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: kPad, right: kPad, top: kPad, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              imagePath: _controller.currentImagePath,
              customPainter: _controller.customPainter,
            ),
          ],
        ),
      ),
    );
  }

  Widget _scanButton() {
    return SuperButton(
      maxWidth: 250,
      height: 35,
      onPressed: () => _controller.scan(),
      label: 'Scan',
    );
  }
}
