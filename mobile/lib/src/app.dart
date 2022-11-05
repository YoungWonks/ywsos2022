import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/bindings/initial_bindings.dart';
import 'package:mobile/src/core/settings/themes/themes.dart';
import 'package:mobile/src/features/auth_feature/login_view.dart';
import 'package:mobile/src/core/settings/themes/themes_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return GetMaterialApp(
      initialBinding: InitialBinding(),
      themeMode: themeController.theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
