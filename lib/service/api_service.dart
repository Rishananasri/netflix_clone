import 'package:dio/dio.dart';
import 'package:netflix_api/service/api_constants.dart';

class TmdbService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchMovies(String endpoint) async {
    try {
      final url = "${ApiConstants.baseUrl}$endpoint";
      final response = await _dio.get(url);

      final results = response.data["results"] as List;

      return results.map((movie) => movie as Map<String, dynamic>).toList();

    } catch (e) {
      print("TMDB fetchMovies error: $e");
      return [];
    }
  }
}
