import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_mentor_chat/message.dart';
import 'package:student_mentor_chat/message_handler.dart';

class MentorChatScreen extends StatefulWidget {
  
  @override
  _MentorChatScreenState createState() => _MentorChatScreenState();
}
void _showExportDialog(BuildContext context) {
    final messageHandler = Provider.of<MessageHandler>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Export Message"),
          content: TextField(
            decoration: InputDecoration(labelText: "Enter topic/question"),
            onChanged: (value) {
              messageHandler.exportTopic = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle exporting the chat to the general chat space
                messageHandler.exportChatToGeneral();
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
class _MentorChatScreenState extends State<MentorChatScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var messageHandler = Provider.of<MessageHandler>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.pushNamed(context, '/general');
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
            icon: Icon(Icons.explore),
            onPressed: () {
               _showExportDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Reverse the list order
              itemCount: messageHandler.mentorMessages.length,
              itemBuilder: (context, index) {
                var message = messageHandler.mentorMessages.reversed.toList()[index];
                bool isLocalMessage = message.sender == MessageSender.Mentor;
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
                      messageHandler.sendMessage(message, MessageSender.Mentor);
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





