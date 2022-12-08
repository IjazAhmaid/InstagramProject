import 'package:flutter/material.dart';
import 'package:instagram_app/Models/users.dart';
import 'package:instagram_app/resources/auth_meathod.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethod = AuthMethod();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
