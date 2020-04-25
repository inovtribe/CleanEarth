import 'package:flutter/foundation.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/services/firebase_auth_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class SignInViewModel extends BaseModel {
  final FirebaseAuthService _auth = locator<FirebaseAuthService>();

  void signInAnonymously() async {
    setIsLoading(true);
    setErrors("");

    var result = await _auth.signInAnonymously();
    setIsLoading(false);

    if (result is String) {
      setErrors(result);
    }

    notifyListeners();
  }

  Future signInWithEmail({
    @required String email,
    @required String password,
  }) async {
    setIsLoading(true);
    setErrors("");

    var result = await _auth.loginWithEmail(
      email: email,
      password: password,
    );
    setIsLoading(false);

    if (result is String) {
      setErrors(result);
    }
  }

  void signOut() async {
    setIsLoading(true);
    setErrors("");

    var result = await _auth.signOut();
    setIsLoading(false);

    if (result is String) {
      setErrors(result);
    }

    notifyListeners();
  }
}
