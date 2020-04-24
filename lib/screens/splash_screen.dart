import 'package:flutter/material.dart';
import 'package:timwan/screens/home_screen.dart';
import 'package:timwan/screens/signin_screen.dart';
import 'package:timwan/services/firebase_auth_service.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuthService();
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInScreen();
          }
          return HomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
