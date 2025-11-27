import 'package:flutter/material.dart';
import '../API/game_api.dart';
import '../model/gamedetail_model.dart';

class GameDetailScreen extends StatelessWidget {
  final int gameId;

  const GameDetailScreen({required this.gameId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GameDetailModel>(
      future: DioService().fetchGameDetails(gameId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.red)),
          );
        }

        final game = snapshot.data!;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(game.name),
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(game.image),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        game.name,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Play",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  game.description,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
