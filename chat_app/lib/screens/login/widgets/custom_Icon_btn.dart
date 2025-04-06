import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final Function() onTap;
  const CustomIconBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onTap(), icon: const Icon(Icons.arrow_forward));
  }
}
