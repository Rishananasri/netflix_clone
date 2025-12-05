import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controller/game_provider.dart';
import 'widgets/game_detail.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    final List<String> posters = [
      "assets/images/poster/game1.jpg",
      "assets/images/poster/game2.jpg",
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GameProvider>(context, listen: false);
      if (provider.games.isEmpty && !provider.isLoading) {
        provider.loadGames();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Consumer<GameProvider>(
          builder: (context, provider, _) {
            return !provider.isSearching
                ? const Text(
                    "Games",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  )
                : TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Search games...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: provider.setSearchQuery,
                  );
          },
        ),
        actions: [
          Consumer<GameProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: Icon(provider.isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  provider.toggleSearch();
                  if (!provider.isSearching) {
                    _searchController.clear();
                    provider.setSearchQuery('');
                  }
                },
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<GameProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          final categories = provider.gamesByCategory;
          if (categories.isEmpty) {
            return const Center(
              child: Text(
                "No games available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final limitedCategories = categories.entries.take(4).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                CarouselSlider(
                  items: posters.map((path) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        path,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 220,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 30),
                  ),
                ),
                const SizedBox(height: 20),
                ...limitedCategories.map((entry) {
                  if (entry.value.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: entry.value.length,
                          itemBuilder: (context, index) {
                            final game = entry.value[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          GameDetailScreen(gameId: game.id),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 140,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl: game.image.isNotEmpty
                                              ? game.image
                                              : "https://via.placeholder.com/120x140.png?text=No+Image",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                                color: Colors.grey.shade800,
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                color: Colors.grey.shade700,
                                                child: const Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        game.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
