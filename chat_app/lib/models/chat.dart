class Chat {
  final String name;
  final String image;
  final String date;
  final List<ChatConv> chatConv;

  Chat({
    required this.name,
    required this.image,
    required this.date,
    required this.chatConv,
  });
}

class ChatConv {
  final String date;
  final String text;
  final bool isSender;

  ChatConv({required this.date, required this.text, required this.isSender});
}
