import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/providers/create_report_details.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/screens/splash_screen.dart';
import 'package:timwan/viewmodels/signin_view_model.dart';
import 'package:timwan/viewmodels/signup_view_model.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainAppDetails(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateReportDetails(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Trash Cleanup App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
