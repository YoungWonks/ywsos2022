import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/settings/themes/theme_service.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ThemeService().changeThemeMode();
              },
              child: Text('Switch Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
