import 'package:flutter/material.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/ui/screens/home_screen.dart';
import 'package:timwan/ui/screens/signin_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = locator<AuthenticationService>();
    return FutureBuilder(
      future: auth.isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
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
