import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color.fromRGBO(83, 195, 56, 1),
      secondary: Colors.white,
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(color: Color(0xFF007605), fontSize: 55),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFF7CE26B),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xFF7CE26B),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.green,
      hoverColor: Colors.green,
      focusColor: Colors.green,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF007605),
          width: 4,
        ),
      ),
      hintStyle: TextStyle(
        fontSize: 19.77,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007605),
        foregroundColor: Colors.black,
        fixedSize: Size(Get.width / 2, Get.height / 20),
      ),
    ),
  );
}
