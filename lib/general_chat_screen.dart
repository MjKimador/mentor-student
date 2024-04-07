import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_mentor_chat/message.dart';
import 'package:student_mentor_chat/message_handler.dart';

class GeneralChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('general chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/mentor');
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Consumer<MessageHandler>(
        builder: (context, messageHandler, _) {
          List<Message> generalMessages = messageHandler.generalMessages;

          return ListView.builder(
            itemCount: generalMessages.length,
            itemBuilder: (context, index) {
              Message message = generalMessages[index];
              bool isMentorMessage = message.sender == MessageSender.Mentor;

              return Wrap(
                alignment: isMentorMessage ? WrapAlignment.end : WrapAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isMentorMessage ? Colors.blue : Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${message.timestamp.hour}:${message.timestamp.minute}',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
