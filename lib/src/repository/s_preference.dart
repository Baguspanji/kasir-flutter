import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("Token", value);
}

Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("Token");
}

Future rmvToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("Token");
}

Future setRole(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("Role", value);
}

Future getRole() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("Role");
}

Future rmvRole() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("Role");
}

Future setStyleHome(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("StyleHome", value);
}

Future getStyleHome() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool("StyleHome");
}

Future rmvStyleHome() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("StyleHome");
}

Future setUser(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("User", value);
}

Future getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("User");
}

Future rmvUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("User");
}
