import 'package:chat_app/mainScreen/main_bloc.dart';
import 'package:chat_app/mainScreen/widgets/profile_card_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ChatRoom> chatRooms = [];
  Future<void> getRoomDetails() async {
    CollectionReference rooms =
        FirebaseFirestore.instance.collection('chat_rooms');

    try {
      QuerySnapshot snapshot = await rooms.get();

      setState(() {
        chatRooms = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Extract chatConv details
          List<RoomDetails> chatConv = (data['List'] as List<dynamic>?)
                  ?.map((chat) => RoomDetails(
                        date: chat['date'] ?? '',
                        text: chat['text'] ?? '',
                        senderID: chat['senderId'] ?? 0,
                        // image: chat['image'] != null
                        // ? Uint8List.fromList(List<int>.from(chat['image']))
                        // : null,
                      ))
                  .toList() ??
              [];

          return ChatRoom(
            name: data['name'] ?? 'Unnamed Room',
            image: data['image'] ?? '',
            chatConv: chatConv,
          );
        }).toList();
      });

      for (var doc in snapshot.docs) {
        print('hello ${doc.id} => ${doc.data()}');
      }
    } catch (error) {
      print("Failed to fetch chat rooms: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    getRoomDetails();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = MainBloc();
    // bloc.fillChatList();
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Chats",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      )),
      body: chatRooms.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (ctx, index) {
                return ProfileCardView(
                  details: chatRooms[index],
                );
              },
            ),
    );
  }
}
