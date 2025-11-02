import 'package:flutter/material.dart';

import '../../core/constants/shared_pref_keys.dart';
import '../../core/services/shared_preferences_service.dart';

class ThemeNotifier {
  static final isDarkNotifier = ValueNotifier(false);

  static Future<void> loadTheme() async {
    final prefs = SharedPreferencesService();
    isDarkNotifier.value = prefs.getBool(SharedPrefKeys.isDark);
  }

  static Future<void> toggleTheme() async {
    final prefs = SharedPreferencesService();
    isDarkNotifier.value = !isDarkNotifier.value;
    await prefs.setBool(SharedPrefKeys.isDark, !isDarkNotifier.value);
  }
}
