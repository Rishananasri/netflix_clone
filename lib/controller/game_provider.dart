import 'package:flutter/material.dart';
import 'package:netflix_api/API/game_api.dart';
import 'package:netflix_api/model/gamedetail_model.dart';

class GameProvider extends ChangeNotifier {
  final DioService _dioService = DioService();

  List<GameDetailModel> games = [];
  GameDetailModel? gameDetails;
  List<GameDetailModel> suggestedGames = [];

  bool isLoading = false;
  bool isDetailLoading = false;
  bool isSuggestedLoading = false;

  /// ---------------------- LOAD ALL GAMES ----------------------
  Future<void> loadGames() async {
    try {
      isLoading = true;
      notifyListeners();

      games = await _dioService.fetchGames();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ---------------------- LOAD GAME DETAILS ----------------------
  Future<void> loadGameDetails(int id) async {
    try {
      isDetailLoading = true;
      notifyListeners();

      gameDetails = await _dioService.fetchGameDetails(id);

      isDetailLoading = false;
      notifyListeners();
    } catch (e) {
      isDetailLoading = false;
      notifyListeners();
    }
  }
}
