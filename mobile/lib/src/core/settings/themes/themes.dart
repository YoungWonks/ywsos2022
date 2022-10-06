import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
      colorScheme: const ColorScheme.light().copyWith(
          primary: const Color.fromRGBO(83, 195, 56, 1),
          secondary: Colors.white));
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 92, 92, 193),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color.fromRGBO(57, 57, 255, 1),
      secondary: Colors.grey,
    ),
  );
}
