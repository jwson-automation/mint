import 'package:flutter/material.dart';

import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetatils();
    _user = user;

    notifyListeners();
  }
}
