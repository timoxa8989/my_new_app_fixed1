import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/message.dart';

class ChatService {
  final String baseUrl = 'https://api.example.com/chats';

  Future<List<Message>> getMessages(String chatId) async {
    final response = await http.get(Uri.parse('$baseUrl/$chatId/messages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((msg) => Message.fromJson(msg)).toList();
    } else {
      throw Exception('Ошибка загрузки сообщений');
    }
  }

  Future<Message> sendMessage(String chatId, String text) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$chatId/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка отправки сообщения');
    }
  }
}
