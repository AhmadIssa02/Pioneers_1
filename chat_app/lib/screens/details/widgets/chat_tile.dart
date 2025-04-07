import 'package:chat_app/models/chat.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  final Function? onDelete;
  final Function? onUpdate;
  final int nickname;
  final RoomDetails message;

  const ChatTile(
      {super.key,
      required this.message,
      this.onDelete,
      this.onUpdate,
      required this.nickname});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  late TextEditingController _controller;
  bool isEditing = false; // Track whether the message is being edited

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.message.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onDelete!();
                print('Message deleted');
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _handleUpdate() {
    widget.onUpdate!(widget.message.text, _controller.text);
    setState(() {
      isEditing = false; // Stop editing after updating
    });
  }

  @override
  Widget build(BuildContext context) {
    print("widget.message.image ${widget.message.chatImage}");
    return Align(
      alignment: widget.message.senderID == widget.nickname
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.message.senderID == widget.nickname
              ? Colors.blueGrey[400]
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.message.chatImage.isNotEmpty)
                    Image.network(
                      widget.message.chatImage,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                  isEditing
                      ? SizedBox(
                          width: 200, // Set width if needed
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Edit message",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          widget.message.text,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                  SizedBox(height: 5),
                  Text(
                    widget.message.date,
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.message.senderID == widget.nickname
                            ? Colors.grey[200]
                            : Colors.grey[700]),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              widget.message.senderID == widget.nickname
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isEditing = !isEditing; // Toggle the editing state
                        });
                      },
                      child: Icon(Icons.edit),
                    )
                  : Container(),
              const SizedBox(
                width: 6,
              ),
              if (isEditing)
                InkWell(
                  onTap: _handleUpdate,
                  child: Icon(Icons.check),
                ),
              const SizedBox(
                width: 6,
              ),
              widget.message.senderID == widget.nickname
                  ? InkWell(
                      onTap: () {
                        _showDeleteConfirmationDialog(context);
                      },
                      child: Icon(Icons.delete),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
