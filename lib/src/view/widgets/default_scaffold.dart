import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/settings/page/settings_view.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const DefaultScaffold({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: body);
  }
}
