import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  String name = "";
  String password = "";

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    name = prefs.getString('name') ?? "";
    password = prefs.getString('password') ?? "";

    notifyListeners();
  }

  Future<void> login(String inputName, String inputPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('name', inputName);
    await prefs.setString('password', inputPassword);

    name = inputName;
    password = inputPassword;
    isLoggedIn = true;

    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    isLoggedIn = false;
    name = "";
    password = "";

    notifyListeners();
  }
}
