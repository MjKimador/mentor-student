enum MessageSender {
  Student,
  Mentor,
}

class Message {
  String text;
  DateTime timestamp;
  MessageSender sender;

  Message({required this.text, required this.timestamp, required this.sender});
}


