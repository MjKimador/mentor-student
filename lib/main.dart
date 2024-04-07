import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_mentor_chat/general_chat_screen.dart';
import 'package:student_mentor_chat/mentor_chat_screen.dart';
import 'package:student_mentor_chat/message_handler.dart'; // Import your MessageHandler class
import 'package:student_mentor_chat/student_chat_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageHandler()),
        // Add other providers if needed
      ],
      child: MaterialApp(
        title: 'Student Mentor Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => StudentChatScreen(),
          '/mentor': (context) => MentorChatScreen(),
          '/general': (context) => GeneralChatScreen(),
        },
      ),
    );
  }
}






