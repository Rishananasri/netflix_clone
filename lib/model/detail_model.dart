// class ContentModel {
//   final String id;
//   final String title;
//   final String? description;
//   final String? image;
//   final String? releaseDate;
//   final bool isMovie;

//   ContentModel({
//     required this.id,
//     required this.title,
//     this.description,
//     this.image,
//     this.releaseDate,
//     required this.isMovie,
//   });

//   /// ----------- GAME FROM RAWG API -----------
//   factory ContentModel.fromGameJson(Map<String, dynamic> json) {
//     return ContentModel(
//       id: json["id"].toString(),
//       title: json["name"] ?? "Unknown Game",
//       description: json["description_raw"] ?? json["description"] ?? "No description available.",
//       image: json["background_image"],
//       releaseDate: json["released"],
//       isMovie: false,
//     );
//   }

//   /// ----------- MOVIE FROM TMDB -----------
//   factory ContentModel.fromMovieJson(Map<String, dynamic> json) {
//     return ContentModel(
//       id: json["id"].toString(),
//       title: json["title"] ?? json["name"] ?? "Unknown Movie",
//       description: json["overview"] ?? "No description available.",
//       image: json["poster_path"] != null
//           ? "https://image.tmdb.org/t/p/w500${json["poster_path"]}"
//           : null,
//       releaseDate: json["release_date"] ?? json["first_air_date"],
//       isMovie: true,
//     );
//   }
// }
