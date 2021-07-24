import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  final String email = "email";

  Future<bool> saveEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setString(email, email);
  }

  Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(email);
  }
}
