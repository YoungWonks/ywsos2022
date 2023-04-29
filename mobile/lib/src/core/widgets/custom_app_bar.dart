import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/settings/settings_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text('$title'),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => ThemeView());
            },
            icon: const Icon(Icons.settings))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Get.height / 10);
}
