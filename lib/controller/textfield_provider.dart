import 'package:flutter/material.dart';

class TextFieldProvider extends ChangeNotifier {
  Map<String, bool> focusStates = {};

  bool isFocused(String id) {
    return focusStates[id] ?? false;
  }

  void setFocus(String id, bool value) {
    focusStates[id] = value;
    notifyListeners();
  }
}
