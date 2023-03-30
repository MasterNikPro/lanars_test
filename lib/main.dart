import 'package:flutter/material.dart';
import 'package:lanars_test/features/home/screens/detail_screen.dart';
import 'package:lanars_test/features/home/screens/home_screen.dart';
import 'package:lanars_test/features/home/screens/search_screen.dart';
void main() {
  runApp( const MyApp());
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
        '/':(context)=>const HomePage(),
        '/search_screen':(context)=> const SearchScreen(),
        '/detailed_screen':(context)=>const DetailScreen(unsplashImage: null),
      },
    );
  }
}
