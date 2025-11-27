import 'package:flutter/material.dart';
import 'package:netflix_api/api/api_service.dart';
import '../API/api_constants.dart';

class MovieProvider extends ChangeNotifier {
  final TmdbService _service = TmdbService();

  List<String> posters = [];
  bool isLoading = false;

  Future<void> loadMovies() async {
    isLoading = true;
    notifyListeners();

    final result = await _service.fetchMovies(ApiConstants.popularMovies);

    posters = result
        .map((movie) => "${ApiConstants.imageBase}${movie['poster_path']}")
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
