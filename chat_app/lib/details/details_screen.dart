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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach ScrollController
              itemCount: widget.details.chatConv.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.details.chatConv[index].isSender
                      ? Row(
                          children: [
                            const Spacer(),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey[400]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  widget.details.chatConv[index].text,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey[400]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  widget.details.chatConv[index].text,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                );
              },
            ),
          ),
          Container(
            color: Colors.pink,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
