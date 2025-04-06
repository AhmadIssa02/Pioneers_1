import 'package:chat_app/Services/FirestoreServices.dart';
import 'package:chat_app/screens/mainScreen/main_bloc.dart';
import 'package:chat_app/screens/mainScreen/widgets/custom_appbar.dart';
import 'package:chat_app/screens/mainScreen/widgets/custom_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final int nickname;
  const MainScreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    final bloc = MainBloc();

    return Scaffold(
      appBar: const CustomAppbar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService.chatStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                bloc.fillList(snapshot.data!);
                return bloc.chatRooms.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : CustomListView(
                        nickname: nickname, chatRooms: bloc.chatRooms);
            }
          }),
    );
  }
}
