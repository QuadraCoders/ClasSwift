import 'package:flutter/material.dart';

class User {
  final String id;
  
  User(this.id);
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners(); // Notify listeners that the user has been updated
  }
}
