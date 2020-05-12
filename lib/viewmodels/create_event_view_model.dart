import 'package:timwan/constants/route_names.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/services/location_service.dart';
import 'package:timwan/services/navigation_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class CreateEventViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final LocationService _locationService = locator<LocationService>();

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  Future createEvent({
    String title,
    String description,
    double radius,
  }) async {
    setIsLoading(true);
    setErrors("");

    var user = _authenticationService.currentUser;
    var position = await _locationService.getUserLocation();
    var event = CleanupEvent(
      title: title,
      description: description,
      owner: Owner(uid: user.uid, fullName: user.fullName),
      startTime: startTime.toUtc(),
      endTime: endTime.toUtc(),
      position: position,
      radius: radius,
      volunteerCount: 0,
      createdAt: DateTime.now().toUtc(),
    );
    var result = await _firestoreService.createEvent(event);
    setIsLoading(false);

    if (result is String) {
      setErrors(result);
    } else {
      _navigationService.navigateTo(DashboardScreenRoute);
    }
  }

  void setTime(bool start, DateTime time) {
    if (start) {
      startTime = time;
    } else {
      endTime = time;
    }

    notifyListeners();
  }
}
