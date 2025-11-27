// import 'package:dio/dio.dart';
// import 'package:netflix_api/model/detail_model.dart';
// import 'package:netflix_api/model/game_model.dart';

// class RawgService {
//   final Dio _dio = Dio();

//   final String rawgKey = ""; // Add RAWG key
//   final String tmdbKey = ""; // Add TMDB key

//   // ---------------- RAWG GAMES ----------------
//   Future<List<GameModel>> getGames() async {
//     final url = "https://api.rawg.io/api/games?key=$rawgKey";
//     final response = await _dio.get(url);
//     final results = response.data["results"] as List;
//     return results.map((json) => GameModel.fromJson(json)).toList();
//   }

//   // ---------------- UPCOMING MOVIES ----------------
//   Future<List<ContentModel>> getUpcomingMovies() async {
//     final url =
//         "https://api.themoviedb.org/3/movie/upcoming?api_key=$tmdbKey";
//     final response = await _dio.get(url);
//     final results = response.data["results"] as List;

//     return results
//         .where((m) => m["poster_path"] != null)
//         .map((json) => ContentModel.fromMovieJson(json))
//         .toList();
//   }

//   Future<List<ContentModel>> getTopRatedMovies() async {
//     final url = "https://api.themoviedb.org/3/movie/top_rated?api_key=$tmdbKey";
//     final response = await _dio.get(url);
//     final results = response.data["results"] as List;

//     return results
//         .where((m) => m["poster_path"] != null)
//         .map((json) => ContentModel.fromMovieJson(json))
//         .toList();
//   }

//   Future<List<ContentModel>> getPopularMovies() async {
//     final url = "https://api.themoviedb.org/3/movie/popular?api_key=$tmdbKey";
//     final response = await _dio.get(url);
//     final results = response.data["results"] as List;

//     return results
//         .where((m) => m["poster_path"] != null)
//         .map((json) => ContentModel.fromMovieJson(json))
//         .toList();
//   }

//   Future<List<ContentModel>> getNowPlayingMovies() async {
//     final url =
//         "https://api.themoviedb.org/3/movie/now_playing?api_key=$tmdbKey";
//     final response = await _dio.get(url);
//     final results = response.data["results"] as List;

//     return results
//         .where((m) => m["poster_path"] != null)
//         .map((json) => ContentModel.fromMovieJson(json))
//         .toList();
//   }
// }
