import 'package:flutter/material.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/services/firebase_auth_service.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = locator<FirebaseAuthService>();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Continue Anonymous'),
          onPressed: authService.signInAnonymously,
        ),
      ),
    );
  }
}
