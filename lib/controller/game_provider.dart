import 'package:flutter/material.dart';
import '../API/game_api.dart';
import '../model/gamedetail_model.dart';

class GameProvider extends ChangeNotifier {
  final DioService _dioService = DioService();

  List<GameDetailModel> games = [];
  bool isLoading = false;

  /// ---------------------- LOAD ALL GAMES ----------------------
  Future<void> loadGames({int totalPages = 5, int pageSize = 40}) async {
    isLoading = true;
    notifyListeners();

    try {
      List<GameDetailModel> allGames = [];

      // Fetch multiple pages to get more games
      for (int page = 1; page <= totalPages; page++) {
        final pageGames = await _dioService.fetchGames(page: page, pageSize: pageSize);
        allGames.addAll(pageGames);
      }

      games = allGames;
    } catch (e) {
      print("Error fetching games: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  /// ---------------------- GET GAMES BY CATEGORY ----------------------
  Map<String, List<GameDetailModel>> get gamesByCategory {
    Map<String, List<GameDetailModel>> map = {};
    for (var game in games) {
      final category = game.category.isNotEmpty ? game.category : "Unknown";
      if (!map.containsKey(category)) {
        map[category] = [];
      }
      map[category]!.add(game);
    }
    return map;
  }
}
