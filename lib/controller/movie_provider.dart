import 'package:flutter/material.dart';
import 'package:netflix_api/api/api_service.dart';
import 'package:netflix_api/model/movie_model.dart';
import '../API/api_constants.dart';

class MovieRowsProvider extends ChangeNotifier {
  final TmdbService _service = TmdbService();

  List<MovieModel> row1 = [];
  List<MovieModel> row2 = [];
  List<MovieModel> row3 = [];

  bool isLoading = false;

  Future<void> loadAll() async {
    isLoading = true;
    notifyListeners();

    row1 = await fetchMovieList(ApiConstants.topRatedMovies);
    row2 = await fetchMovieList(ApiConstants.popularMovies);
    row3 = await fetchMovieList(ApiConstants.nowPlayingMovies);

    isLoading = false;
    notifyListeners();
  }

  /// Helper to fetch and convert API response to List<MovieModel>
  Future<List<MovieModel>> fetchMovieList(String endpoint) async {
    final List data = await _service.fetchMovies(endpoint); // returns List<dynamic>
    
    return data
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}
