import 'package:flutter/material.dart';
import '../../models/message.dart';
import '../../services/chat_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final String userName;

  const ChatDetailScreen({super.key, required this.chatId, required this.userName});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> with TickerProviderStateMixin {
  List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await ChatService().getMessages(widget.chatId);
    setState(() {
      _messages = messages;
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final newMessage = await ChatService().sendMessage(widget.chatId, _messageController.text);

    setState(() {
      _messages.insert(0, newMessage);
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    AnimationController(
                      duration: const Duration(milliseconds: 300),
                      vsync: this,
                    )..forward(),
                  ),
                  child: Align(
                    alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.isMine ? Colors.pink[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.text),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
