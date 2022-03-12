import 'package:ocrrub/main.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

import '../common.dart';

///Used for showing notifications like a Snackbar or Banner

void showMaterialBanner(String title) {
  return _showMaterialBannerInScrollView(Text(title),
      leading: const Icon(Icons.info_outline_rounded));
}

void showMaterialBannerTextDiff(String oldText, String newText) {
  return _showMaterialBannerInScrollView(PrettyDiffText(
    defaultTextStyle: TextStyle(color: Colors.white),
    oldText: oldText,
    newText: newText,
  ));
}

void showMaterialBannerText(String text) {
  return _showMaterialBannerInScrollView(Text(text));
}

void _showMaterialBannerInScrollView(Widget child, {Widget? leading}) {
  final context = navigatorKey.currentContext;
  if (context == null) return;
  ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
    padding: const EdgeInsets.all(kPad),
    content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: SingleChildScrollView(child: child)),
    backgroundColor: Theme.of(context).bannerTheme.backgroundColor,
    forceActionsBelow: true,
    actions: [
      TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Text('Dismiss')),
    ],
  ));
}

void showSnackbar(String title) {
  final context = navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
    ));
  }
}
