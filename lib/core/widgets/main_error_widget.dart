import 'package:flutter/material.dart';

import 'main_button.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainButton(text: 'Try Again', onPressed: onPressed),
    );
  }
}
