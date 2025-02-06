import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  final WebSocketChannel _channel =
      WebSocketChannel.connect(Uri.parse('wss://api.example.com/chat'));

  void sendMessage(String chatId, String message) {
    _channel.sink.add('{"chatId": "$chatId", "message": "$message"}');
  }

  Stream<dynamic> get messagesStream => _channel.stream;

  void dispose() {
    _channel.sink.close();
  }
}
