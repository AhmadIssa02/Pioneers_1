import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  bool isSender;
  String text;
  ChatTile({super.key, required this.isSender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSender ? const Spacer() : const SizedBox(),
        Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSender ? Colors.grey[300] : Colors.blueGrey[400]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Text(
              text,
              textAlign: TextAlign.end,
            ),
          ),
        ),
        isSender ? const SizedBox() : const Spacer(),
      ],
    );
  }
}
