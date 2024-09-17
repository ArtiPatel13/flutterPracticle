
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static final AppPreference _instance = AppPreference._internal();

  factory AppPreference() {
    return _instance;
  }

  AppPreference._internal() {
    // initialization logic
  }

  SharedPreferences? pref;

  Future<void> initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  void clearPref() {

  }


  

  bool get isLogin =>
      pref?.getBool( 'isLogin') ?? false;

  set isLogin(bool value) {
    pref?.setBool('isLogin', value);
  }

}
