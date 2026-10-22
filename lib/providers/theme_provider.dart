import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _isDark = p.getBool('dark_mode') ?? false;
  }

  Future<void> setDark(bool value) async {
    _isDark = value;
    notifyListeners();
    final p = await SharedPreferences.getInstance();
    await p.setBool('dark_mode', value);
  }

  void resetAfterClear() {
  _isDark = false;
  notifyListeners();
}
}
