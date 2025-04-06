import 'package:chat_app/screens/details/details_screen.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final ChatRoom details;
  final int nickname;

  const GroupTile({super.key, required this.details, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () => _navigateToDetailsScreen(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(details.image),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 10),
            CustomText(text: details.name),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return DetailsScreen(
            details: details,
            nickname: nickname,
          );
        },
      ),
    );
  }
}
