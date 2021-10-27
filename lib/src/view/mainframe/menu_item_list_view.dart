import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_blocker_view.dart';
import 'package:ocrrub/src/view/mainframe/mlkit/text_detector_view.dart';
import 'package:ocrrub/src/view/widgets/default_scaffold.dart';

import '../settings/settings_view.dart';
import 'menu_item.dart';

class MenuItemListView extends StatelessWidget {
  const MenuItemListView({
    Key? key,
    this.items = const [
      MenuItem(TextDetectorView.routeName, name: 'Text Detector'),
      MenuItem(TextBlockerView.routeName, name: 'Text Blocker'),
    ],
  }) : super(key: key);

  static const routeName = '/';

  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        title: AppLocalizations.of(context)!.appTitle,
        body: ListView.builder(
          restorationId: 'sampleItemListView',
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return ListTile(
                title: Text(item.name ?? ''),
                leading: const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                ),
                onTap: () {
                  Navigator.restorablePushNamed(
                    context,
                    item.targetRouteName,
                  );
                }
            );
          },
        ),
    );
  }
}