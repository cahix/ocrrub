import 'package:ocrrub/src/view/ocr/ocr_controller.dart';

import '../common.dart';

class DefaultScaffoldScreenshotButton extends StatelessWidget {
  const DefaultScaffoldScreenshotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OCRController>();
    if (controller.hasImage()) {
      return IconButton(
          icon: const Icon(Icons.save_alt_rounded),
          onPressed: () => controller.takeScreenshot()
      );
    }
    else return const SizedBox.shrink();
  }
}
