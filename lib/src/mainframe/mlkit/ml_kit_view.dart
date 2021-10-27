import 'package:flutter/material.dart';
import 'package:ocrrub/src/settings/settings_view.dart';
import 'package:ocrrub/src/widgets/default_scaffold.dart';

class MlKitVIew extends StatelessWidget {
  static const routeName = '/mlkitview';
  const MlKitVIew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        title: 'MlKit',
        body: Container(),
    );
  }
}
