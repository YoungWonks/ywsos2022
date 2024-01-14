import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/core/constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: kButtonColor,
    );
  }
}
