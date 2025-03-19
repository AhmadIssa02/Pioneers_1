import 'package:chat_app/details/widgets/chat_tile.dart';
import 'package:chat_app/mainScreen/main_bloc.dart';
import 'package:chat_app/models/chat.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Chat details;
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
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
      backgroundColor: isDark ? Colors.black : Colors.white,
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
                      isSender: widget.details.chatConv[index].isSender,
                      text: widget.details.chatConv[index].text,
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
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => {
                        if (controller.text.trim().isNotEmpty)
                          {
                            widget.details.chatConv.add(ChatConv(
                              date: MainBloc().getCurrentDateTime(),
                              text: controller.text,
                              isSender: true,
                            )),
                            widget.onUpdate(),
                            setState(() {}),
                            controller.clear(),
                            Future.delayed(
                                Duration(milliseconds: 100), _scrollToBottom),
                          }
                      },
                      controller: controller,
                      decoration:
                          InputDecoration(hintText: "Type a message..."),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        widget.details.chatConv.add(ChatConv(
                          date: MainBloc().getCurrentDateTime(),
                          text: controller.text,
                          isSender: true,
                        ));
                        widget.onUpdate();
                        setState(() {});
                        controller.clear();
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
