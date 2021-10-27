import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ocrrub/src/mainframe/mlkit/ml_kit_view.dart';
import 'package:ocrrub/src/widgets/default_scaffold.dart';

import '../settings/settings_view.dart';
import 'menu_item.dart';

class MenuItemListView extends StatelessWidget {
  const MenuItemListView({
    Key? key,
    this.items = const [MenuItem(MlKitVIew.routeName, name: 'MlKit')],
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
