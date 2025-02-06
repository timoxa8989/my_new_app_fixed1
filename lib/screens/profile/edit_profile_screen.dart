import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = await UserService().getProfile();
    setState(() {
      _user = user;
      _nameController.text = user.name;
      _bioController.text = user.bio ?? '';
    });
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);

    await UserService().updateProfile(
      name: _nameController.text,
      bio: _bioController.text,
    );

    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать профиль')),
      body: _user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Имя'),
                  ),
                  TextField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'О себе'),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _updateProfile,
                          child: const Text('Сохранить'),
                        ),
                ],
              ),
            ),
    );
  }
}
