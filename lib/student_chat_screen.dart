import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_mentor_chat/message.dart';
import 'package:student_mentor_chat/message_handler.dart';


class StudentChatScreen extends StatefulWidget {
  @override
  _StudentChatScreenState createState() => _StudentChatScreenState();
}

class _StudentChatScreenState extends State<StudentChatScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var messageHandler = Provider.of<MessageHandler>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Chat'),
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
              Navigator.pushNamed(context, '/general');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Reverse the list order
              itemCount: messageHandler.studentMessages.length,
              itemBuilder: (context, index) {
                var message = messageHandler.studentMessages.reversed.toList()[index];
                bool isLocalMessage = message.sender == MessageSender.Student;
                return Align(
                  alignment: isLocalMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isLocalMessage ? Colors.greenAccent : Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: isLocalMessage ? Radius.circular(12) : Radius.zero,
                        bottomRight: isLocalMessage ? Radius.zero : Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.text),
                          SizedBox(height: 4),
                          Text(
                            message.timestamp.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),





          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    var message = _messageController.text;
                    if (message.isNotEmpty) {
                      messageHandler.sendMessage(message, MessageSender.Student);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



