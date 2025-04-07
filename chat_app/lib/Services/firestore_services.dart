import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static const collectionName = "chat_rooms";
  static Stream<QuerySnapshot> chatStream =
      FirebaseFirestore.instance.collection(collectionName).snapshots();

  final FirebaseStorage _storageInstance = FirebaseStorage.instance;

  Stream<DocumentSnapshot<Object?>> getDocumentsStream(String docName) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .snapshots();
  }

  Future<void> add(ChatRoom chat) {
    CollectionReference chats =
        FirebaseFirestore.instance.collection(collectionName);

    return chats
        .doc(chat.name)
        .update({
          'image': chat.image,
          'List': chat.chatConv,
        })
        .then((value) => debugPrint("User added successfully!"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  Future<void> fetchRoom() {
    CollectionReference chats =
        FirebaseFirestore.instance.collection(collectionName);

    return chats.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        debugPrint('${doc.id} => ${doc.data()}');
      }
    }).catchError((error) {
      debugPrint("Failed to fetch users: $error");
      return;
    });
  }

  Future<void> addChatMessage(
      String roomName, RoomDetails message, File? attachment) async {
    CollectionReference chats =
        FirebaseFirestore.instance.collection(collectionName);

    final imagePath = await _uploadFileToFirebaseStorage(attachment);

    debugPrint(imagePath);

    return chats
        .doc(roomName)
        .update({
          'List': FieldValue.arrayUnion([
            {
              'date': message.date,
              'text': message.text,
              'senderId': message.senderID,
              'image': imagePath ?? "",
              'messageId': message.messageId
            }
          ]),
        })
        .then((_) => debugPrint("Message added successfully!"))
        .catchError((error) => debugPrint("Failed to add message: $error"));
  }

  Future<void> deleteChatMessage(String roomName, RoomDetails message) {
    CollectionReference chats =
        FirebaseFirestore.instance.collection(collectionName);

    return chats
        .doc(roomName)
        .update({
          'List': FieldValue.arrayRemove([
            {
              'date': message.date,
              'text': message.text,
              'senderId': message.senderID,
              'image': message.chatImage,
              'messageId': message.messageId
            }
          ]),
        })
        .then((_) => debugPrint("Message deleted successfully!"))
        .catchError((error) => debugPrint("Failed to delete message: $error"));
  }

  Future<void> editChatMessage(
      String roomName, RoomDetails oldMessage, RoomDetails newMessage) async {
    CollectionReference chats =
        FirebaseFirestore.instance.collection(collectionName);

    try {
      DocumentSnapshot docSnapshot = await chats.doc(roomName).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        List<dynamic> chatConv = data['List'];

        for (int i = 0; i < chatConv.length; i++) {
          // debugPrint(chatConv[i]);
          if (chatConv[i]['messageId'] == oldMessage.messageId) {
            debugPrint("-------------------/n---------------/n ${chatConv[i]}");
            chatConv[i] = {
              'date': newMessage.date,
              'text': newMessage.text,
              'senderId': newMessage.senderID,
              'image': newMessage.chatImage,
              'messageId': oldMessage.messageId
            };
            break;
          }
        }

        await chats.doc(roomName).update({
          'List': chatConv,
        });

        debugPrint("Message updated successfully!");
      } else {
        debugPrint("Chat room not found!");
      }
    } catch (error) {
      debugPrint("Failed to update message: $error");
    }
  }

  Future<String?> getDocumentIdByName(String name) async {
    try {
      CollectionReference chats =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot =
          await chats.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document's ID (since we assume 'name' is unique)
        String documentId = querySnapshot.docs.first.id;
        debugPrint('Document ID for room "$name": $documentId');
        return documentId;
      } else {
        debugPrint('No document found with the name: $name');
        return null;
      }
    } catch (error) {
      debugPrint('Error fetching document ID: $error');
      return null;
    }
  }

  Future<String?> _uploadFileToFirebaseStorage(File? attach) async {
    if (attach == null) return null;

    final String extension = _getFileExtension(attach.path);
    final String fileName = _generateFileName(extension);

    try {
      final ref = _storageInstance.ref('chat_attachment/$fileName');
      await ref.putFile(attach);
      return await ref.getDownloadURL();
    } catch (error) {
      debugPrint('Error uploading file: $error');
      return '';
    }
  }

  /// Extracts the file extension from a file path.
  String _getFileExtension(String filePath) {
    return filePath.split('.').last;
  }

  /// Generates a unique file name using the current timestamp and file extension.
  String _generateFileName(String extension) {
    return '${DateTime.now().toIso8601String()}.$extension';
  }
}
