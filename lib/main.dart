import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainAppDetails())],
      child: MaterialApp(
        title: 'Trash Cleanup App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
