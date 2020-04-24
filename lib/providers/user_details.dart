import 'package:flutter/widgets.dart';
import 'package:timwan/services/firebase_auth_service.dart';

class UserDetails with ChangeNotifier {
  UserDetails({@required this.auth});

  final FirebaseAuthService auth;
  User user;

  void signIn() async {
    user = await auth.signInAnonymously();
    notifyListeners();
  }

  void signOut() async {
    await auth.signOut();
    user = null;
    notifyListeners();
  }
}
