import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_api/view/widgets/homeScreen/carousel_button.dart.dart';

class MovieCarousel extends StatelessWidget {
  final List<String> posters;

  const MovieCarousel({super.key, required this.posters});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color.fromARGB(255, 215, 215, 215),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 400,
                  child: CarouselSlider.builder(
                    itemCount: posters.length,
                    itemBuilder: (context, index, _) {
                      return Image.network(
                        posters[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                    options: CarouselOptions(
                      height: 500,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 30),
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 35,
            child: Image.asset(
              "assets/images/netflix.logo-removebg-preview.png",
              height: 35,
            ),
          ),
          Positioned(bottom: 10, left: 50, child: CarouselButton()),
        ],
      ),
    );
  }
}
