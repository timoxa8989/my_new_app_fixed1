import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  List<User> _users = [];
  CardController? controller;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await UserService().getUsers();
    setState(() {
      _users = users;
    });
  }

  void _handleSwipe(int index, CardSwipeOrientation orientation) {
    if (orientation == CardSwipeOrientation.LEFT) {
      print('Отклонение пользователя: ${_users[index].name}');
    } else if (orientation == CardSwipeOrientation.RIGHT) {
      print('Матч с пользователем: ${_users[index].name}');
      // Тут можно добавить логику для матча, например, отправить запрос на сервер
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Поиск')),
      body: _users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : TinderSwapCard(
              orientation: AmassOrientation.TOP,
              totalNum: _users.length,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width * 0.85,
              minHeight: MediaQuery.of(context).size.height * 0.55,
              cardController: controller,
              swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                print(align);
              },
              swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                _handleSwipe(index, orientation);
              },
              cardBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Image.network(
                          _users[index].avatar ?? 'https://placekitten.com/400/400',
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _users[index].name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
