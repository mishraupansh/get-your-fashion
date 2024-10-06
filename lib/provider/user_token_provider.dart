import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_model.dart';

class UserTokenProvider with ChangeNotifier {
  Future<bool> saveUser(AuthModel user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.userId.toString());
    notifyListeners();
    return true;
  }

  Future<AuthModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    return AuthModel(userId: token.toString());
  }

  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}