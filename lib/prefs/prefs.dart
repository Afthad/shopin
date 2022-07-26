import 'package:hive/hive.dart';

class PrefsBoxKeys {
  static const saveLogin = 'login';
}

class PrefsDb {
  static var prefsBox = Hive.box('prefs');

  static Box get box => prefsBox;

  static String? get getLoginDetails => prefsBox.get(PrefsBoxKeys.saveLogin);

  static void saveLogin(String? login) =>
      prefsBox.put(PrefsBoxKeys.saveLogin, login);
}
