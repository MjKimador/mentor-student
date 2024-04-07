import 'package:flutter/foundation.dart';
import 'package:student_mentor_chat/message.dart';

class MessageHandler extends ChangeNotifier {
  List<Message> studentMessages = [];
  List<Message> mentorMessages = [];

  void sendMessage(String text, MessageSender sender) {
    DateTime timestamp = DateTime.now();
    Message message = Message(text: text, timestamp: timestamp, sender: sender);

    // Add message to studentMessages if sent by student or mentor
    if (sender == MessageSender.Student || sender == MessageSender.Mentor) {
      studentMessages.add(message);
    }

    // Add message to mentorMessages if sent by mentor or student
    if (sender == MessageSender.Mentor || sender == MessageSender.Student) {
      mentorMessages.add(message);
    }

    notifyListeners();
  }
}









