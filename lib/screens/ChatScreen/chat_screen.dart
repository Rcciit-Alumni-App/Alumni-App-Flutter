import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Chat Page',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Bottomnavbar(),
    );
  }
}