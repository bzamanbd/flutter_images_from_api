import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
void main()=>runApp(const MyApp());
class MyApp extends StatelessWidget {
  final String appTitle='Images from API';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: const HomeScreen(),
      routes: {
        '/home-screen':(_)=>const HomeScreen(),
      },
    );
  }
}