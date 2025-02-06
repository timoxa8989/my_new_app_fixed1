import 'package:flutter/material.dart';
import 'package:annabrides_app/screens/chat/chat_detail_screen.dart';  // Экран для чата

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Чаты')),
      body: ListView(
        children: [
          // Пример списка чатов
          ListTile(
            title: const Text('Пользователь 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatDetailScreen(userName: 'Пользователь 1'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Пользователь 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatDetailScreen(userName: 'Пользователь 2'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
