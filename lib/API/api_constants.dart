class ApiConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageBase = "https://image.tmdb.org/t/p/w500";

  static const String apiKey =
      "393e5591926a7cdd0970afda2757b95d"; 

  static String topRatedMovies = "/movie/top_rated?api_key=$apiKey";

  static String popularMovies = "/movie/popular?api_key=$apiKey";

  static String upcomingMovies = "/movie/upcoming?api_key=$apiKey";
}
