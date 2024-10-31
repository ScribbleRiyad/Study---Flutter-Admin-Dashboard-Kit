import 'package:shared_preferences/shared_preferences.dart';
import 'package:study/helpers/services/auth_service.dart';
import 'package:study/helpers/services/localizations/language.dart';
import 'package:study/helpers/theme/theme_customizer.dart';

class LocalStorage {
  static const String _loggedInUserKey = "user";
  static const String _themeCustomizerKey = "theme_customizer";
  static const String _languageKey = "lang_code";

  static SharedPreferences? _preferencesInstance;

  static SharedPreferences get preferences {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  static Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
  }

  static Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    AuthService.isLoggedIn = preferences.getBool(_loggedInUserKey) ?? false;
    ThemeCustomizer.fromJSON(preferences.getString(_themeCustomizerKey));
  }

  static Future<bool> setLoggedInUser(bool loggedIn) async {
    return preferences.setBool(_loggedInUserKey, loggedIn);
  }

  static Future<bool> setCustomizer(ThemeCustomizer themeCustomizer) {
    return preferences.setString(_themeCustomizerKey, themeCustomizer.toJSON());
  }

  static Future<bool> setLanguage(Language language) {
    return preferences.setString(_languageKey, language.locale.languageCode);
  }

  static String? getLanguage() {
    return preferences.getString(_languageKey);
  }

  static Future<bool> removeLoggedInUser() async {
    return preferences.remove(_loggedInUserKey);
  }
}
