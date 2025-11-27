import 'package:flutter/material.dart';
import 'package:netflix_api/API/api_constants.dart';
import 'package:netflix_api/API/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final TmdbService _service = TmdbService();

  List<String> posters = [];
  bool isLoading = false;

  Future<void> loadMovies() async {
    isLoading = true;
    notifyListeners();

    final movies = await _service.fetchMovies(ApiConstants.popularMovies);

    posters = movies.map((movie) {
      return "https://image.tmdb.org/t/p/w500${movie['poster_path']}";
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}
