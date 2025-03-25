import 'package:chat_app/models/chat.dart';
import 'package:intl/intl.dart';

class MainBloc {
  List<ChatRoom> chatList = [];
  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('hh:mm aa');
    final String formatted = formatter.format(now);
    return formatted;
  }

  void fillChatList() {
    chatList = [
      ChatRoom(
        name: 'suad',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzPRQ6LprnPzvvP-_vVO_nhSokwda8CMsnwQ&s',
        chatConv: [RoomDetails(date: "11", senderID: 1, text: "hello")],
      ),
      ChatRoom(
          name: 'abed',
          image:
              'https://t4.ftcdn.net/jpg/06/08/55/73/360_F_608557356_ELcD2pwQO9pduTRL30umabzgJoQn5fnd.jpg',
          chatConv: [
            RoomDetails(date: "10:37", text: "first", senderID: 1),
            RoomDetails(date: "10:37", text: "ok", senderID: 1),
            RoomDetails(date: "10:37", text: "text", senderID: 2),
            RoomDetails(date: "10:37", text: "last", senderID: 1)
          ]),
      ChatRoom(
          name: 'layla',
          image:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMGltYWdlfGVufDB8fDB8fHww',
          chatConv: [
            RoomDetails(date: "10:37", text: "first", senderID: 1),
            RoomDetails(date: "10:37", text: "ok", senderID: 2),
            RoomDetails(date: "10:37", text: "text", senderID: 1),
            RoomDetails(date: "10:37", text: "ada", senderID: 2),
            RoomDetails(date: "10:37", text: "text", senderID: 1),
            RoomDetails(date: "10:37", text: "last", senderID: 1)
          ]),
      ChatRoom(
          name: 'sawsan',
          image:
              'https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=',
          chatConv: [
            RoomDetails(date: "10:37", text: "text", senderID: 1),
            RoomDetails(date: "10:37", text: "ok", senderID: 2),
            RoomDetails(date: "10:37", text: "text", senderID: 1),
            RoomDetails(date: "10:37", text: "text", senderID: 1)
          ]),
    ];
  }
}
