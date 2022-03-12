import 'package:ocrrub/src/view/settings/settings_view.dart';

import '../common.dart';
import 'default_scaffold_screenshotbutton.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const DefaultScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
          leading: DefaultScaffoldScreenshotButton(),
          actions: [
            _settingsButton(context),
          ],
        ),
        body: SafeArea(child: body),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }

  Widget _settingsButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined,size: 22,),
      onPressed: () {
        Navigator.restorablePushNamed(context, SettingsView.routeName);
      },
    );
  }
}
