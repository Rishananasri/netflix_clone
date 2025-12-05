class ApiConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";

  static const String apiKey = "393e5591926a7cdd0970afda2757b95d";

  static String popularMovies =
      "/movie/popular?api_key=$apiKey&region=US&page=1";
  static String topRatedMovies =
      "/movie/top_rated?api_key=$apiKey&region=US&page=1";
  static String upcomingMovies =
      "/movie/upcoming?api_key=$apiKey&region=US&page=2";
  static String nowPlayingMovies =
      "/movie/now_playing?api_key=$apiKey&region=US&page=3";
}
