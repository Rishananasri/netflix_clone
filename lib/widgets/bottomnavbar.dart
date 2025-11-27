import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_api/controller/navbar_provider.dart';
import 'package:netflix_api/screens/Home_screen.dart';
import 'package:netflix_api/screens/game_screen.dart';
import 'package:netflix_api/screens/profile_screen.dart';
import 'package:netflix_api/screens/video_screen.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      HomeScreen(),
      GameScreen(),
      VideoScreen(),
      ProfileScreen(),
    ];

    return Consumer<BottomNavProvider>(
      builder: (context, nav, child) {
        return Scaffold(
          backgroundColor: Colors.black,

          body: IndexedStack(index: nav.currentIndex, children: widgetList),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: nav.currentIndex,
            onTap: nav.changeIndex,

            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,

            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.game_controller),
                activeIcon: Icon(CupertinoIcons.game_controller_solid),
                label: "Games",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_collection_outlined),
                activeIcon: Icon(Icons.video_collection),
                label: "New & Hot",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_3_outlined),
                activeIcon: Icon(Icons.person_3),
                label: "My Netflix",
              ),
            ],
          ),
        );
      },
    );
  }
}
