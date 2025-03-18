import 'package:chat_app/mainScreen/main_bloc.dart';
import 'package:chat_app/mainScreen/widgets/profile_card_view.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = MainBloc();
    bloc.fillChatList();
    return Scaffold(
      appBar: AppBar(title: Text("Chats")),
      body: ListView.builder(
        itemCount: bloc.chatList.length,
        itemBuilder: (ctx, index) {
          return ProfileCardView(
            details: bloc.chatList[index],
          );
        },
      ),
    );
  }
}
