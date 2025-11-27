import 'package:flutter/material.dart';
import 'package:netflix_api/model/gamedetail_model.dart';
import 'package:netflix_api/widgets/game_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:netflix_api/controller/game_provider.dart';

class HomescreenWidgets extends StatelessWidget {
  const HomescreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Mobile Games", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Text("See All", style: TextStyle(color: Colors.white)),
                Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),

        Consumer<GameProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return buildShimmer();
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: provider.games
                    .map((game) => buildGameItem(game, context))
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(8, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade700,
              child: Container(
                height: 130,
                width: 120,
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

  Widget buildGameItem(GameDetailModel game, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GameDetailScreen(gameId: game.id)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              height: 130,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white10,
                image: DecorationImage(
                  image: NetworkImage(game.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              game.name,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              game.category,
              style: TextStyle(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
