import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_watch/app/constant.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/di.dart';

final numProvider = StateProvider((ref) => 0);

final savedProvider = StateProvider((ref) =>
    instance<SharedPreferences>().getStringList(Constant.PREF_KEY_SET_SAVED) ??
    []);
final savedSearchProvider = StateProvider((ref) =>
    instance<SharedPreferences>()
        .getStringList(Constant.PREF_KEY_SET_SAVED_SEARCH) ??
    []);
final bookMarkBoolProvider = StateProvider((ref) =>
    instance<SharedPreferences>().getBool(Constant.PREF_KEY_SET_BOOL) ?? false);

final bookMarkProvider = StateProvider<bool>((ref) => true);
final loadingBool = StateProvider<bool>((ref) => true);
final searchProvider = StateProvider((ref) => true);
final changeTextFieldProvider = StateProvider((ref) => true);
