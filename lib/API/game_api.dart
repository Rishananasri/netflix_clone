import 'package:dio/dio.dart';
import 'package:netflix_api/model/gamedetail_model.dart';

class DioService {
  final Dio _dio = Dio();

  final String baseUrl = "https://api.rawg.io/api/games";
  final String apiKey = "15cf8d04ce9d4bc1b7ace59cb703e3da";

  Future<List<GameDetailModel>> fetchGames() async {
    final String url = "$baseUrl?key=$apiKey";

    final response = await _dio.get(url);
    final List results = response.data["results"];

    return results.map((json) => GameDetailModel.fromJson(json)).toList();
  }

  Future<GameDetailModel> fetchGameDetails(int id) async {
    final String url = "$baseUrl/$id?key=$apiKey";

    final response = await _dio.get(url);
    return GameDetailModel.fromJson(response.data);
  }
}
