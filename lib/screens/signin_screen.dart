import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/providers/user_details.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserDetails>(context);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Continue Anonymous'),
          onPressed: userDetails.signIn,
        ),
      ),
    );
  }
}
