import 'package:flutter/material.dart';
import 'package:lanars_test/features/home/screens/detail_screen.dart';
import 'package:lanars_test/features/home/screens/home_screen.dart';
import 'package:lanars_test/features/home/screens/search_screen.dart';
import 'package:lanars_test/models/unsplash_image.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>HomePage(),
        '/search_screen':(context)=> SearchScreen(),
        '/detailed_screen':(context)=>DetailScreen(unsplashImage: null),
      },
    );
  }
}
