import 'package:timwan/constants/route_names.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/services/navigation_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class EventDetailsViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _isUserPartOfEvent = false;
  bool get isUserPartOfEvent => _isUserPartOfEvent;

  void initilize(String eventUid) async {
    setIsLoading(true);
    setErrors("");

    var result = await _firestoreService.isUserPartOfEvent(
      eventUid: eventUid,
      userUid: _authenticationService.currentUser.uid,
    );
    setIsLoading(false);

    if (result is bool) {
      _isUserPartOfEvent = result;
      notifyListeners();
    }
  }

  void onFabPressed(String eventUid) {
    if (_isUserPartOfEvent) {
      _navigationService.navigateTo(
        CreateReportScreenRoute,
        arguments: eventUid,
      );
    } else {
      setIsLoading(true);
      _firestoreService.addUserToEvent(
        eventUid: eventUid,
        userUid: _authenticationService.currentUser.uid,
      );
      initilize(eventUid);
      setIsLoading(false);
    }
  }
}
