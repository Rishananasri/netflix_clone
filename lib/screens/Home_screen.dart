import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/movie_provider.dart';
import '../controller/game_provider.dart';
import '../controller/search_provider.dart';
import '../widgets/homeScreen/carousel_slider.dart';
import '../widgets/homeScreen/filtered_button.dart';
import '../widgets/homeScreen/game_row.dart';
import '../widgets/homeScreen/homescreen_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieProvider = Provider.of<MovieRowsProvider>(
        context,
        listen: false,
      );
      if (!movieProvider.isLoading && movieProvider.row1.isEmpty) {
        movieProvider.loadAll();
      }

      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      if (!gameProvider.isLoading && gameProvider.games.isEmpty) {
        gameProvider.loadGames();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/images/netflix.logo-removebg-preview.png"),
        ),
        title: Consumer<SearchProvider>(
          builder: (context, search, _) {
            if (search.isSearching) {
              return TextField(
                controller: search.controller,
                focusNode: search.focusNode,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.red,
                decoration: const InputDecoration(
                  hintText: "Search movies and games...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: (value) => search.setQuery(value),
              );
            } else {
              return const Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 27,
                  color: Colors.white,
                ),
              );
            }
          },
        ),
        actions: [
          Icon(Icons.download, color: Colors.white),
          Consumer<SearchProvider>(
            builder: (context, search, _) => IconButton(
              icon: Icon(
                search.isSearching ? Icons.close : CupertinoIcons.search,
                color: Colors.white,
              ),
              onPressed: () => search.toggleSearch(),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 130),
            const TopFilterButtons(),
            const SizedBox(height: 20),

            Consumer<SearchProvider>(
              builder: (context, search, _) {
                final movieProvider = Provider.of<MovieRowsProvider>(
                  context,
                  listen: false,
                );
                final gameProvider = Provider.of<GameProvider>(
                  context,
                  listen: false,
                );

                final query = search.query.toLowerCase();

                final movies = query.isEmpty
                    ? []
                    : movieProvider.row1
                          .where((m) => m.title.toLowerCase().contains(query))
                          .toList();

                final games = query.isEmpty
                    ? []
                    : gameProvider.games
                          .where((g) => g.name.toLowerCase().contains(query))
                          .toList();

                if (!search.isSearching || query.isEmpty) {
                  return Column(
                    children: [
                      Consumer<MovieRowsProvider>(
                        builder: (context, value, _) {
                          if (value.isLoading) {
                            return const SizedBox(
                              height: 500,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }

                          final posters = value.row1
                              .map((m) => m.posterUrl.toString())
                              .toList();
                          return MovieCarousel(posters: posters);
                        },
                      ),
                      GameRow(title: '', games: gameProvider.games),
                      HomescreenWidget(),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movies.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Movies",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final m = movies[index];
                          final img =
                              m.posterUrl ?? 'https://via.placeholder.com/150';
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: img,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(color: Colors.grey.shade800),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                m.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      ),
                    ],

                    if (games.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Games",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: games.length,
                        itemBuilder: (context, index) {
                          final g = games[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: g.image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(color: Colors.grey.shade800),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                g.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      ),
                    ],

                    if (movies.isEmpty && games.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
