import 'package:chat_app/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainBloc {
  List<ChatRoom> chatRooms = [];

  fillList(QuerySnapshot<Object?> snapshot) {
    chatRooms = snapshot.docs.map((doc) => _mapToChatRoom(doc)).toList();
  }

  ChatRoom _mapToChatRoom(QueryDocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>;

    final chatConv = _mapToRoomDetailsList(data['List'] as List<dynamic>?);

    return ChatRoom(
      name: doc.id,
      image: data['image'] ?? '',
      chatConv: chatConv,
    );
  }

  List<RoomDetails> _mapToRoomDetailsList(List<dynamic>? chatList) {
    if (chatList == null) return [];

    return chatList.map((chat) => _mapToRoomDetails(chat)).toList();
  }

  RoomDetails _mapToRoomDetails(Map<String, dynamic> chat) {
    return RoomDetails(
        date: chat['date'] ?? '',
        text: chat['text'] ?? '',
        senderID: chat['senderId'] ?? 0,
        messageId: chat['messageId'] ?? "0",
        chatImage: chat["image"] ?? ""
        // image: chat['image'] != null
        //   ? Uint8List.fromList(List<int>.from(chat['image']))
        //   : null,
        );
  }
}
