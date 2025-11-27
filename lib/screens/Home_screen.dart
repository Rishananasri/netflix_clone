import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_api/controller/carousel_provider.dart';
import 'package:netflix_api/widgets/homeScreen/homescreen_widget.dart';
import 'package:provider/provider.dart';
import 'package:netflix_api/widgets/homeScreen/carousel_slider.dart';
import 'package:netflix_api/widgets/homeScreen/filtered_button.dart';
import 'package:netflix_api/widgets/homeScreen/game_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      if (movieProvider.posters.isEmpty && !movieProvider.isLoading) {
        movieProvider.loadMovies();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/images/netflix.logo-removebg-preview.png"),
        ),
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
        ),
        actions: const [
          Icon(CupertinoIcons.arrow_down_to_line),
          SizedBox(width: 16),
          Icon(CupertinoIcons.search),
          SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 130),
                const TopFilterButtons(),
                const SizedBox(height: 20),
                Consumer<MovieProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const SizedBox(
                        height: 500,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.red),
                        ),
                      );
                    }

                    if (value.posters.isEmpty) {
                      return const Center(
                        child: Text(
                          "No images",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return MovieCarousel(posters: value.posters);
                  },
                ),
                GameRow(title: '', games: [],),
                HomescreenWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
