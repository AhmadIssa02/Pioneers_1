import '/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static const collectionName = "chat_rooms";
  static Stream<QuerySnapshot> chatStream =
      FirebaseFirestore.instance.collection(collectionName).snapshots();

  Stream<DocumentSnapshot<Object?>> getDocumentsStream(String docName) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .snapshots();
  }

  static CollectionReference chats =
      FirebaseFirestore.instance.collection(collectionName);

  // Future<void> add(ChatRoom chat) {
  //   return chats
  //       .doc(chat.name)
  //       .update({
  //         'image': chat.image,
  //         'List': chat.chatConv,
  //       })
  //       .then((value) => print("User added successfully!"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  // Future<void> fetchRoom() {
  //   return chats.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       print('${doc.id} => ${doc.data()}');
  //     });
  //   }).catchError((error) => print("Failed to fetch users: $error"));
  // }

  Future<void> addChatMessage(String roomName, RoomDetails message) {
    // TODO: add actual image
    return chats
        .doc(roomName)
        .update({
          'List': FieldValue.arrayUnion([
            {
              'date': message.date,
              'text': message.text,
              'senderId': message.senderID,
              'image': "",
            }
          ]),
        })
        .then((_) => print("Message added successfully!"))
        .catchError((error) => print("Failed to add message: $error"));
  }

  Future<void> deleteChatMessage(String roomName, RoomDetails message) {
    // TODO: add actual image
    return chats
        .doc(roomName)
        .update({
          'List': FieldValue.arrayRemove([
            {
              'date': message.date,
              'text': message.text,
              'senderId': message.senderID,
              'image': "",
            }
          ]),
        })
        .then((_) => print("Message deleted successfully!"))
        .catchError((error) => print("Failed to delete message: $error"));
  }

  Future<void> editChatMessage(
      String roomName, RoomDetails oldMessage, RoomDetails newMessage) async {
    try {
      DocumentSnapshot docSnapshot = await chats.doc(roomName).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        List<dynamic> chatConv = data['List'];

        for (int i = 0; i < chatConv.length; i++) {
          if (chatConv[i]['date'] == oldMessage.date &&
              chatConv[i]['senderId'] == oldMessage.senderID &&
              chatConv[i]['text'] == oldMessage.text) {
            chatConv[i] = {
              'date': newMessage.date,
              'text': newMessage.text,
              'senderId': newMessage.senderID,
              'image': newMessage.image ?? "",
            };
            break;
          }
        }

        await chats.doc(roomName).update({
          'List': chatConv,
        });

        print("Message updated successfully!");
      } else {
        print("Chat room not found!");
      }
    } catch (error) {
      print("Failed to update message: $error");
    }
  }
}
