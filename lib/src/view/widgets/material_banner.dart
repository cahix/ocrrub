import 'package:ocrrub/main.dart';

import '../common.dart';

void showMaterialBanner(String title) {
  final context = navigatorKey.currentContext;
  if(context == null) return;
  ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        padding: const EdgeInsets.all(kPad),
        content: Text(title),
        leading: const Icon(Icons.info_outline_rounded),
        backgroundColor: Theme.of(context).bannerTheme.backgroundColor,
        actions: [
          TextButton(onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, child: const Text('Dismiss')),
        ],
      ));
}

void showMaterialBannerForText(String text) {
  final context = navigatorKey.currentContext;
  if(context == null) return;
  ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        padding: const EdgeInsets.all(kPad),
        content: SizedBox(
            height: MediaQuery.of(context).size.height/2,
            child: SingleChildScrollView(child: Text(text))),
        backgroundColor: Theme.of(context).bannerTheme.backgroundColor,
        forceActionsBelow: true,
        actions: [
          TextButton(onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, child: const Text('Dismiss')),
        ],
      ));
}

void showSnackbar(String title) {
  final context = navigatorKey.currentContext;
  if(context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title),));
  }
}