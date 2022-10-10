import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setSaved(List<String> save) async {
    _sharedPreferences.setStringList(Constant.PREF_KEY_SET_SAVED, save);
  }

  Future<void> setSavedSearch(List<String> saveSearch) async {
    _sharedPreferences.setStringList(
        Constant.PREF_KEY_SET_SAVED_SEARCH, saveSearch);
  }

  Future<void> setBookMarkBool(bool bookMark) async {
    _sharedPreferences.setBool(Constant.PREF_KEY_SET_BOOL, bookMark);
  }
}
