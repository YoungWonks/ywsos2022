import 'package:flutter/material.dart';
import 'package:mobile/src/core/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      extendBodyBehindAppBar: true,
      body: Text('Home'),
    );
  }
}
