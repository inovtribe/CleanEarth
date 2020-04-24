import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/providers/create_report_details.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/providers/user_details.dart';
import 'package:timwan/screens/splash_screen.dart';
import 'package:timwan/services/firebase_auth_service.dart';

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
          create: (_) => UserDetails(auth: locator<FirebaseAuthService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateReportDetails(),
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
