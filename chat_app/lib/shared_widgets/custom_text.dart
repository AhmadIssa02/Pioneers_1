import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  const CustomText(
      {super.key,
      required this.text,
      this.padding = const EdgeInsets.all(8.0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
