import 'package:flutter/material.dart';
import 'package:movie_book_app/firebase_services%20/firebase_services.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();

    splashServices.isLogin(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            child: Image.network(
              'https://t3.ftcdn.net/jpg/04/66/39/50/360_F_466395040_mj2YjwJe0qLlRXQk51kg0q8Jw9AwJp5r.jpg',
            ),
          ),
        ));
  }
}
