import 'package:flutter/material.dart';
import 'package:netflix_api/controller/carousel_provider.dart';
import 'package:netflix_api/controller/game_provider.dart';
import 'package:netflix_api/controller/movie_provider.dart';
import 'package:netflix_api/controller/navbar_provider.dart';
import 'package:netflix_api/widgets/bottomnavbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()..loadMovies()),
        ChangeNotifierProvider(create: (_) => GameProvider()..loadGames()),
        ChangeNotifierProvider(create: (_)=>MovieRowsProvider()..loadAll())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BottomNav(), debugShowCheckedModeBanner: false);
  }
}

final String rawgKey = "15cf8d04ce9d4bc1b7ace59cb703e3da";
final String tmdbKey = "393e5591926a7cdd0970afda2757b95d";
