class User {
  final String id;
  final String name;
  final String? avatar;
  final String? bio;

  User({required this.id, required this.name, this.avatar, this.bio});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      bio: json['bio'],
    );
  }
}
