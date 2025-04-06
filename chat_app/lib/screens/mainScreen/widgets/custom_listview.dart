import 'package:chat_app/models/chat.dart';
import 'package:chat_app/screens/mainScreen/widgets/group_tile.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final int nickname;
  final List<ChatRoom> chatRooms;

  const CustomListView(
      {super.key, required this.chatRooms, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatRooms.length,
      itemBuilder: (ctx, index) {
        return GroupTile(
          details: chatRooms[index],
          nickname: nickname,
        );
      },
    );
  }
}
