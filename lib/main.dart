import 'package:flutter/material.dart';
import 'package:netflix_api/controller/carousel_provider.dart';
import 'package:netflix_api/controller/game_provider.dart';
import 'package:netflix_api/controller/login_provider.dart';
import 'package:netflix_api/controller/movie_provider.dart';
import 'package:netflix_api/controller/navbar_provider.dart';
import 'package:netflix_api/controller/search_provider.dart';
import 'package:netflix_api/controller/textfield_provider.dart';
import 'package:netflix_api/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()..loadMovies()),
        ChangeNotifierProvider(create: (_) => GameProvider()..loadGames()),
        ChangeNotifierProvider(create: (_) => MovieRowsProvider()..loadAll()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splashscreen(), debugShowCheckedModeBanner: false);
  }
}
