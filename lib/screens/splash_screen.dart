import 'package:flutter/material.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/screens/home_screen.dart';
import 'package:timwan/screens/signin_screen.dart';
import 'package:timwan/services/authentication_service.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = locator<AuthenticationService>();
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
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
