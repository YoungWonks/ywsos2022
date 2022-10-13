import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobile/src/core/settings/settings_view.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // your customization here
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
  Size get preferredSize => const Size.fromHeight(50);
}
