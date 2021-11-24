
import 'package:ocrrub/src/view/ocr/widgets/text_diff_view.dart';
import 'package:ocrrub/src/view/ocr/widgets/image_view.dart';
import 'package:ocrrub/src/view/settings/widgets/ocr_expected_text_settings.dart';
import 'package:ocrrub/src/view/widgets/default_scaffold.dart';
import 'package:ocrrub/src/view/widgets/loading_indicator.dart';
import 'package:ocrrub/src/view/widgets/super_button.dart';

import '../common.dart';
import 'ocr_view_controller.dart';

class OCRView extends StatefulWidget {
  static const String routeName = '/ocrview';

  @override
  _OCRViewState createState() => _OCRViewState();
}

class _OCRViewState extends State<OCRView> {
  static const double buttonHeight = 40;
  late OCRViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<OCRViewController>();
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
    if(_controller.isScanning) {
      return Center(child: LoadingIndicator.medium());
    }
    return PageView(
      controller: _controller.pageController,
      children: [
        _imageView(),
        if(_controller.ocrText != null) TextDiffView(),
      ],
    );
  }

  Widget _imageView() {
    if(_controller.currentImagePath == null) {
      return Center(
        child: Padding(
            padding: const EdgeInsets.only(bottom: buttonHeight),
            child: OCRExpectedTextSettings(),
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: kPad, bottom: 2*buttonHeight),
        child: Column(
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
    return SizedBox(
      width: 250,
      height: buttonHeight,
      child: ElevatedButton(
          onPressed: () => _controller.scan(),
          child: Text('Scan'),
        style: ElevatedButton.styleFrom(primary: primaryColor),
      ),
    );
  }
}
