import 'package:shared_preferences/shared_preferences.dart';

import '../global/global_settings.dart';

class UserCredentials {
  static const String _prefix = '_'; // Unique prefix for keys
  static const String _usernameKey = _prefix + 'username';
  static const String _passwordKey = _prefix + 'password';

  Future<void> saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
    globalData.updateData(); // Update GlobalData after saving credentials
  }

  Future<Map<String, String>> getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(_usernameKey);
    String? password = prefs.getString(_passwordKey);
    return {'username': username ?? '', 'password': password ?? ''};
  }
}

UserCredentials userCredentials = UserCredentials();
