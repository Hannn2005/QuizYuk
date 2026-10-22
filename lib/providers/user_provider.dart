import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String get name => _name;
  bool get hasName => _name.isNotEmpty;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _name = p.getString('user_name') ?? '';
  }

  Future<void> setName(String value) async {
    _name = value.trim();
    notifyListeners();
    final p = await SharedPreferences.getInstance();
    await p.setString('user_name', _name);
  }

 void resetAfterClear() {
  _name = '';
  notifyListeners();
}
}
