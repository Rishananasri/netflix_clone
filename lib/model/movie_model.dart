class MovieModel {
  final String title;
  final String posterUrl;
  final String releaseDate;
  final String description;

  MovieModel({
    required this.title,
    required this.posterUrl,
    required this.releaseDate,
    required this.description,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json["title"] ?? "",
      posterUrl: "https://image.tmdb.org/t/p/w500${json["poster_path"] ?? ""}",
      releaseDate: json["release_date"] ?? "",
      description: json["overview"] ?? "",
    );
  }
}
