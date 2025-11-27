class GameDetailModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final List<String> genres;
  final String category;

  GameDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.genres,
    required this.category,
  });

  factory GameDetailModel.fromJson(Map<String, dynamic> json) {
    return GameDetailModel(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description_raw'] ?? "",
      image: json['background_image'] ?? "",
      genres: (json['genres'] as List).map((g) => g['name'] as String).toList(),
      category: (json["genres"] != null && json["genres"].isNotEmpty)
          ? json["genres"][0]["name"]
          : "Unknown",
    );
  }
}
