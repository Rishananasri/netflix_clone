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
    final imageUrl = (json['background_image'] != null && json['background_image'] != "")
        ? json['background_image']
        : "https://via.placeholder.com/400x200.png?text=No+Image";

    final genresList = (json['genres'] as List<dynamic>?)
            ?.map((g) => g['name'] as String)
            .toList() ??
        [];

    final category = (genresList.isNotEmpty) ? genresList[0] : "Unknown";

    return GameDetailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown Game",
      description: json['description_raw'] ?? "",
      image: imageUrl,
      genres: genresList,
      category: category,
    );
  }

  get title => null;
}
