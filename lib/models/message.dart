class Message {
  final String id;
  final String text;
  final bool isMine;

  Message({required this.id, required this.text, required this.isMine});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      text: json['text'],
      isMine: json['isMine'],
    );
  }
}
