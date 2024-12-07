import 'package:flutter/material.dart';
import 'package:k_pop_hub/services/theme_service.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = _themeData == ThemeService.lightTheme
        ? ThemeService.darkTheme
        : ThemeService.lightTheme;
    notifyListeners();
  }
}
