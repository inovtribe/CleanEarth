import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/providers/user_details.dart';
import 'package:timwan/screens/home_screen.dart';
import 'package:timwan/services/firebase_auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth = FirebaseAuthService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainAppDetails()),
        ChangeNotifierProvider(
          create: (_) => UserDetails(auth: auth),
        )
      ],
      child: MaterialApp(
        title: 'Trash Cleanup App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
