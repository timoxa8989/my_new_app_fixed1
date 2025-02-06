import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchUsers() async {
    setState(() => _isLoading = true);

    final users = await UserService().searchUsers(_searchController.text);
    setState(() {
      _searchResults = users;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Поиск пользователей')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Введите имя',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchUsers,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final user = _searchResults[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.avatar != null
                                ? NetworkImage(user.avatar!)
                                : const AssetImage('assets/user.png') as ImageProvider,
                          ),
                          title: Text(user.name),
                          onTap: () {
                            // Открытие профиля пользователя
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
