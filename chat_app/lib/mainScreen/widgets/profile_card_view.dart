import 'package:chat_app/details/details_screen.dart';
import 'package:chat_app/mainScreen/main_bloc.dart';
import 'package:chat_app/models/chat.dart';
import 'package:flutter/material.dart';

class ProfileCardView extends StatefulWidget {
  final ChatRoom details;
  // final Function onUpdate;
  const ProfileCardView({super.key, required this.details});

  @override
  State<ProfileCardView> createState() => _ProfileCardViewState();
}

class _ProfileCardViewState extends State<ProfileCardView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) {
                return DetailsScreen(
                  details: widget.details,
                  onUpdate: () {
                    setState(() {});
                  },
                );
              },
            ),
          ),
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(widget.details.image),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.details.name),
                Text(widget.details.chatConv.last.text)
              ],
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
