import 'package:flutter/foundation.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class SignUpViewModel extends BaseModel {
  final _authService = locator<AuthenticationService>();

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setIsLoading(true);
    setErrors("");

    var result = await _authService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
    );
    setIsLoading(false);

    if (result is String) {
      setErrors(result);
    }
  }
}
