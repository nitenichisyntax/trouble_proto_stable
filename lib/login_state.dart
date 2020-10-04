import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  String _id = '';
  bool isLoggedIn() => _loggedIn;
  String idLogged() => _id;

  void login(id) {
    _loggedIn = true;
    _id = id;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _id = '';
    notifyListeners();
  }
}
