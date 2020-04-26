import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/providers/create_report_details.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/services/navigation_service.dart';
import 'package:timwan/ui/router.dart';
import 'package:timwan/ui/screens/splash_screen.dart';
import 'package:timwan/viewmodels/create_event_view_model.dart';
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
        ),
        ChangeNotifierProvider(
          create: (_) => CreateEventViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Trash Cleanup App',
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
