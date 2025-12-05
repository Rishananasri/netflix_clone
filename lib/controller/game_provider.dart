import 'package:flutter/material.dart';
import '../service/game_api.dart';
import '../model/gamedetail_model.dart';

class GameProvider extends ChangeNotifier {
  final DioService _dioService = DioService();

  List<GameDetailModel> games = [];
  bool isLoading = false;

  bool isSearching = false;
  String _searchQuery = "";

  Future<void> loadGames({int totalPages = 5, int pageSize = 40}) async {
    isLoading = true;
    notifyListeners();

    try {
      List<GameDetailModel> allGames = [];

      for (int page = 1; page <= totalPages; page++) {
        final pageGames =
            await _dioService.fetchGames(page: page, pageSize: pageSize);
        allGames.addAll(pageGames);
      }

      games = allGames;
    } catch (e) {
      print("Error fetching games: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      _searchQuery = ""; 
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

  List<GameDetailModel> get filteredGames {
    if (_searchQuery.isEmpty) return games;
    return games
        .where((game) => game.name.toLowerCase().startsWith(_searchQuery))
        .toList();
  }

  Map<String, List<GameDetailModel>> get gamesByCategory {
    Map<String, List<GameDetailModel>> map = {};
    for (var game in filteredGames) {
      final category = game.category.isNotEmpty ? game.category : "Unknown";
      if (!map.containsKey(category)) {
        map[category] = [];
      }
      map[category]!.add(game);
    }
    return map;
  }
}
