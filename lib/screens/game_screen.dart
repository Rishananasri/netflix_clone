import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflix_api/widgets/game_detail.dart';
import 'package:provider/provider.dart';
import '../controller/game_provider.dart';
import '../widgets/homeScreen/game_row.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example carousel images
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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Discover Games",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                // -------- Top Carousel (featured games) --------
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
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                  ),
                ),

                const SizedBox(height: 20),

                // -------- Categories --------
                ...categories.entries.map((entry) {
                  if (entry.value.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Optional: navigate to see all games in this category
                              },
                              child: const Text(
                                "See All",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(game.image),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      left: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          game.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
