import 'dart:typed_data';
import 'package:chat_app/Services/FirestoreServices.dart';
import 'package:chat_app/screens/details/details_bloc.dart';
import 'package:chat_app/screens/details/widgets/chat_tile.dart';
import 'package:chat_app/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsScreen extends StatefulWidget {
  final ChatRoom details;
  final int nickname;
  const DetailsScreen(
      {super.key, required this.details, required this.nickname});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isDark = false;
  bool _flag = true;

  final _bloc = DetailsBloc();

  @override
  void initState() {
    super.initState();
    _scrollToBottom;
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _onSubmit(int senderID) async {
    if (_controller.text.trim().isNotEmpty) {
      FirestoreService().addChatMessage(
          widget.details.name,
          RoomDetails(
            date: DetailsBloc().getCurrentDateTime(),
            text: _controller.text,
            senderID: senderID,
            // image: imageBytes,
          ));
      // widget.onUpdate();
      _controller.clear();
      // imageBytes = null;
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  void _onDelete(RoomDetails message) async {
    FirestoreService().deleteChatMessage(widget.details.name, message);
    setState(() {
      widget.details.chatConv.remove(message);
    });
  }

  void _onUpdate(RoomDetails oldMessage, RoomDetails newMessage) async {
    // String? roomId =
    //     await FirestoreService().getDocumentIdByName(widget.details.name);
    FirestoreService()
        .editChatMessage(widget.details.name, oldMessage, newMessage);

    // Update the chatConv list inside setState
    setState(() {
      // Find the index of the old message and update it
      int index = widget.details.chatConv.indexOf(oldMessage);
      if (index != -1) {
        widget.details.chatConv[index] = newMessage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _bloc.isDarkStream.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor:
                (snapshot.data ?? false) ? Colors.blueGrey[900] : Colors.white,
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
                      final val = (snapshot.data ?? false);
                      _bloc.isDarkStream.sink.add(!val);
                      // isDark = !isDark;
                      // setState(() {});
                    },
                    icon: const Icon(Icons.dark_mode))
              ],
            ),
            body: StreamBuilder<DocumentSnapshot>(
                stream:
                    FirestoreService().getDocumentsStream(widget.details.name),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  print("abbbs 123123");
                  if (snapshot.hasError) return Text('${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      _fillTheList(snapshot.data!);
                      return Column(
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
                                      onDelete: () {
                                        _onDelete(
                                            widget.details.chatConv[index]);
                                      },
                                      onUpdate:
                                          (String oldtext, String newtext) {
                                        RoomDetails oldMessage = RoomDetails(
                                            date: widget
                                                .details.chatConv[index].date,
                                            text: oldtext,
                                            senderID: 1,
                                            messageId: widget.details
                                                .chatConv[index].messageId);
                                        RoomDetails newMessage = RoomDetails(
                                            date: DetailsBloc()
                                                .getCurrentDateTime(),
                                            text: newtext,
                                            senderID: 1,
                                            messageId: widget.details
                                                .chatConv[index].messageId);
                                        _onUpdate(oldMessage, newMessage);
                                      },
                                      nickname: widget.nickname,
                                    ));
                              },
                            ),
                          ),
                          Container(
                            color: Colors.blueGrey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<Uint8List?>(
                                  stream: _bloc.imageBytesStream.stream,
                                  builder: (context, snapshot) {
                                    return Row(
                                      children: [
                                        if (snapshot.data !=
                                            null) // image preview
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _bloc.imageBytesStream.sink
                                                    .add(null);
                                              },
                                              child: Stack(
                                                children: [
                                                  Image.memory(
                                                    snapshot.data!,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  const Icon(Icons.close,
                                                      size: 10),
                                                ],
                                              ),
                                            ),
                                          ),
                                        Expanded(
                                          child: TextField(
                                            onSubmitted: (value) =>
                                                _onSubmit(widget.nickname),
                                            controller: _controller,
                                            decoration: InputDecoration(
                                                hintText: "Type a message...",
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    _bloc.getImage();
                                                    // _pickImage();
                                                  },
                                                  icon: const Icon(
                                                    Icons.attachment,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              _onSubmit(widget.nickname),
                                          icon: const Icon(Icons.send),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
                  }
                }),
          );
        });
  }

  _fillTheList(DocumentSnapshot<Object?> snapshot) {
    final chatConv = _mapToRoomDetailsList(snapshot['List'] as List<dynamic>?);
    widget.details.chatConv = chatConv;
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
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

      // image: chat['image'] != null
      //   ? Uint8List.fromList(List<int>.from(chat['image']))
      //   : null,
    );
  }
}
