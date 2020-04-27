import 'package:flutter/material.dart';
import 'package:timwan/constants/route_names.dart';
import 'package:timwan/ui/screens/create_event_screen.dart';
import 'package:timwan/ui/screens/create_report_screen.dart';
import 'package:timwan/ui/screens/dashboard_screen.dart';
import 'package:timwan/ui/screens/signin_screen.dart';
import 'package:timwan/ui/screens/signup_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInScreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignInScreen(),
      );
    case SignUpScreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpScreen(),
      );
    case DashboardScreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DashboardScreen(),
      );
    case CreateEventScreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateEventScreen(),
      );
    case CreateReportScreenRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateReportScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('Error occured, please restart the app!'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
