import 'package:dio/dio.dart';
import 'api_constants.dart';

class TmdbService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchMovies(String endpoint) async {
    final url = "${ApiConstants.baseUrl}$endpoint";

    final response = await _dio.get(url);
    return response.data["results"];
  }
}
