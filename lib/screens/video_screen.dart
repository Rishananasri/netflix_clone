import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:netflix_api/controller/movie_provider.dart';
import 'package:netflix_api/controller/search_provider.dart';
import 'package:netflix_api/model/movie_model.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieRowsProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);

    List<MovieModel> allMovies = [...movieProvider.row2, ...movieProvider.row3];

    List<MovieModel> filteredMovies = searchProvider.query.isEmpty
        ? allMovies
        : allMovies
              .where(
                (movie) => movie.title.toLowerCase().startsWith(
                  searchProvider.query.toLowerCase(),
                ),
              )
              .toList();

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        title: searchProvider.isSearching
            ? TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search movies and shows...",
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  searchProvider.setQuery(value);
                },
              )
            : Text(
                "New & Hot",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

        actions: [
          GestureDetector(
            onTap: () {
              searchProvider.toggleSearch();
            },
            child: Icon(
              searchProvider.isSearching
                  ? CupertinoIcons.clear
                  : CupertinoIcons.search,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),

      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : searchProvider.query.isNotEmpty
          ? (filteredMovies.isEmpty
                ? Center(
                    child: Text(
                      "No movies found",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : buildGridView(filteredMovies))
          : buildMovieList(allMovies),
    );
  }

  Widget buildMovieList(List<MovieModel> movies) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return movieItem(movies[index]);
      },
    );
  }

  Widget buildGridView(List<MovieModel> movies) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(movies[index].posterUrl, fit: BoxFit.cover),
        );
      },
    );
  }

  Widget movieItem(MovieModel movie) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 340,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      movie.posterUrl,
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      movie.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none_outlined),
                    Text(
                      "Remind Me",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 10,
              child: Image.asset(
                "assets/images/netflix.logo-removebg-preview.png",
                width: 30,
                height: 30,
              ),
            ),

            Positioned(
              top: 140,
              left: 140,
              child: Icon(
                Icons.play_circle_outline_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
