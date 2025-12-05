import 'package:flutter/material.dart';
import 'package:netflix_api/model/movie_model.dart';
import 'package:netflix_api/widgets/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:netflix_api/controller/movie_provider.dart';

class HomescreenWidget extends StatelessWidget {
  const HomescreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieRowsProvider>(
      builder: (context, movies, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            buildRow(
              title: "Gems for You",
              height: 170,
              posters: movies.row1,
              isLoading: movies.isLoading,
              posterWidth: 120,
              context: context,
            ),

            buildRow(
              title: "Supernatural Fantasy TV",
              height: 170,
              posters: movies.row2,
              isLoading: movies.isLoading,
              posterWidth: 120,
              context: context,
            ),

            buildRow(
              title: "Only on Netflix",
              height: 250,
              posters: movies.row3,
              isLoading: movies.isLoading,
              posterWidth: 180,
              context: context,
            ),
          ],
        );
      },
    );
  }

  Widget buildRow({
    required String title,
    required double height,
    required List<MovieModel> posters,
    required bool isLoading,
    required double posterWidth,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8, top: 10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),

        isLoading
            ? buildMovieShimmer(height, posterWidth)
            : buildPosterRow(posters, height, posterWidth, context),
      ],
    );
  }

  Widget buildMovieShimmer(double height, double posterWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(8, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade700,
              child: Container(
                height: height,
                width: posterWidth,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildPosterRow(
    List<MovieModel> posters,
    double height,
    double posterWidth,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: posters
            .map((movie) =>
                buildPoster(movie, height, posterWidth, context))
            .toList(),
      ),
    );
  }

  Widget buildPoster(
    MovieModel movie,
    double height,
    double posterWidth,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieDetailScreen(movie: movie),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height,
            width: posterWidth,
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
