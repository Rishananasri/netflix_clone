import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_api/controller/carousel_provider.dart';
import 'package:netflix_api/widgets/carousel_slider.dart';
import 'package:netflix_api/widgets/filtered_button.dart';
import 'package:netflix_api/widgets/homescreen_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image.asset("assets/images/netflix.logo-removebg-preview.png"),
        ),
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
        ),
        actions: [
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
              children: [
                SizedBox(height: 130),
                TopFilterButtons(),
                SizedBox(height: 20),
                Consumer<MovieProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return SizedBox(height: 500);
                    }

                    if (value.posters.isEmpty) {
                      return Center(
                        child: Text(
                          "No images",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return MovieCarousel(posters: value.posters);
                  },
                ),
                HomescreenWidgets(),
              ],
            ),
          ),

          Consumer<MovieProvider>(
            builder: (context, value, child) {
              if (!value.isLoading) return SizedBox.shrink();

              return Container(
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.red),
              );
            },
          ),
        ],
      ),
    );
  }
}
