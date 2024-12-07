import 'package:flutter/material.dart';

class ThemeService {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[100],
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
  );
}
