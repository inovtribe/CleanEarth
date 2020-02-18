import 'package:flutter/material.dart';
import 'package:timwan/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trash Cleanup App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
