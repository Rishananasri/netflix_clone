import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_api/controller/login_provider.dart';
import 'package:netflix_api/view/login_screen.dart';
import 'package:netflix_api/view/widgets/bottomnavbar.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    // Wait until widget is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();

      // Wait 2 seconds for splash animation & provider to load
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;

        if (auth.isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset(
          "assets/images/poster/netflix_splash.json",
          height: 400,
          width: 500,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
