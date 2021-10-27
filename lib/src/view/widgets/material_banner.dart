import '../common.dart';

void showMaterialBanner(BuildContext context, String title) {
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