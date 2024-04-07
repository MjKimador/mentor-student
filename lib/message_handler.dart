import 'package:flutter/foundation.dart';
import 'package:student_mentor_chat/message.dart';

class MessageHandler extends ChangeNotifier {
  List<Message> studentMessages = [];
  List<Message> mentorMessages = [];
  List<Message> generalMessages = [];
  String exportTopic = '';
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
  void exportChatToGeneral() {
    // Create a copy of mentorMessages
    List<Message> copiedMessages = List.from(mentorMessages);

    // Create a new Message with exportTopic as the first message
    Message exportMessage = Message(
      text: 'Exported Chat: $exportTopic',
      timestamp: DateTime.now(),
      sender: MessageSender.Mentor,
    );

    // Add the export message as the first message in the copied list
    copiedMessages.insert(0, exportMessage);

    // Copy the messages to the generalMessages list
    generalMessages.clear();
    generalMessages.addAll(copiedMessages);

    // Clear the exportTopic and notify listeners
    exportTopic = '';
    notifyListeners();
  }
}









