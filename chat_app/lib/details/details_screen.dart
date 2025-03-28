import 'dart:typed_data';
import 'package:chat_app/details/widgets/chat_tile.dart';
import 'package:chat_app/mainScreen/main_bloc.dart';
import 'package:chat_app/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class DetailsScreen extends StatefulWidget {
  final ChatRoom details;
  final Function() onUpdate;
  const DetailsScreen(
      {super.key, required this.details, required this.onUpdate});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isDark = false;

  Uint8List? imageBytes;
  final ImagePicker _picker = ImagePicker();

  bool flag = true;

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List pickedImageBytes = await pickedFile.readAsBytes();
      setState(() {
        imageBytes = pickedImageBytes;
      });
    }
  }

  Future<void> getRoomDetails() {
    CollectionReference room1 = FirebaseFirestore.instance.collection('room1');

    return room1.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print('${doc.id} => ${doc.data()}');
      });
    }).catchError((error) => print("Failed to fetch users: $error"));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
    getRoomDetails();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.blueGrey[900] : Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(widget.details.image),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 10),
            Text(widget.details.name),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                isDark = !isDark;
                setState(() {});
              },
              icon: const Icon(Icons.dark_mode))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.details.chatConv.length,
              itemBuilder: (ctx, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatTile(
                      message: widget.details.chatConv[index],
                    ));
              },
            ),
          ),
          Container(
            color: Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (imageBytes != null) // image preview
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageBytes = null;
                          });
                        },
                        child: Stack(
                          children: [
                            Image.memory(
                              imageBytes!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            Icon(Icons.close, size: 10),
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => {
                        if (controller.text.trim().isNotEmpty)
                          {
                            widget.details.chatConv.add(
                              RoomDetails(
                                date: MainBloc().getCurrentDateTime(),
                                text: controller.text,
                                senderID: 1,
                              ),
                            ),
                            widget.onUpdate(),
                            setState(() {}),
                            controller.clear(),
                            Future.delayed(
                                Duration(milliseconds: 100), _scrollToBottom),
                          }
                      },
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: "Type a message...",
                          suffixIcon: IconButton(
                            onPressed: () {
                              getImage();
                              // _pickImage();
                            },
                            icon: const Icon(
                              Icons.attachment,
                            ),
                          )),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        widget.details.chatConv.add(
                          RoomDetails(
                              date: MainBloc().getCurrentDateTime(),
                              text: controller.text,
                              senderID: 1,
                              image: imageBytes),
                        );
                        widget.onUpdate();
                        setState(() {});
                        controller.clear();
                        imageBytes = null;
                        Future.delayed(
                            Duration(milliseconds: 100), _scrollToBottom);
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
