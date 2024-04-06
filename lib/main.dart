import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_mentor_chat/message_handler.dart';
import 'package:student_mentor_chat/student_chat_screen.dart';
import 'package:student_mentor_chat/mentor_chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageHandler(),
      child: MaterialApp(
        title: 'Student Mentor Chat',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => StudentChatScreen(),
          '/mentor': (context) => MentorChatScreen(),
        },
      ),
    );
  }
}




