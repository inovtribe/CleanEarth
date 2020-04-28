import 'package:timwan/constants/route_names.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/navigation_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class UserDetailsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    setIsLoading(true);
    await _authenticationService.signOut();
    setIsLoading(false);
    _navigationService.navigateTo(SignInScreenRoute);
  }

  Future<bool> isAnonymous() async {
    return await _authenticationService.isUserAnonymous();
  }

  void navigateToCreateEvent() {
    _navigationService.navigateTo(CreateEventScreenRoute);
  }
}
