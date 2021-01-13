import 'package:shared_preferences/shared_preferences.dart';

/*
  class used to save or read countries from shared preference
*/
class SharedPref {
  readObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get(key) != null) {
      return prefs.get(key);
    } else
      return null;
  }

  saveObject(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
