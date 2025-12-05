import 'package:flutter/material.dart';


class SearchProvider extends ChangeNotifier {
  bool isSearching = false;
  String query = "";
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  SearchProvider() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus && isSearching) {
        toggleSearch();
      }
    });
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      query = "";
      controller.clear();
    }
    notifyListeners();
  }

  void setQuery(String newQuery) {
    query = newQuery;
    notifyListeners();
  }
}
