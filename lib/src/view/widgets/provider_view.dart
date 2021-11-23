import 'package:flutter/cupertino.dart';
import 'package:ocrrub/src/view/common.dart';

class ProviderView<T extends ChangeNotifier> extends StatelessWidget {
  final T provider;
  final Widget child;

  const ProviderView({Key? key, required this.provider, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => provider,
      child: child,
    );
  }
}
