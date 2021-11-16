import '../common.dart';

class SmartChangeNotifier extends ChangeNotifier {
  bool _mounted = true;
  bool get mounted => _mounted;

  @override
  notifyListeners() {
    if(mounted) super.notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}