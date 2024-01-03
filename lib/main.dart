import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_book_app/view/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema',
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
          canvasColor:
              const Color(0xFF260032), // Set the background color to black
        ),
      home: const SplashScreeen()
    );
  }
}

