import 'package:timwan/constants/route_names.dart';
import 'package:timwan/locator.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/services/location_service.dart';
import 'package:timwan/services/navigation_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class UserEventsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();

  List<CleanupEvent> _createdEvents;
  List<CleanupEvent> get createdEvents => _createdEvents;

  List<CleanupEvent> _volunteeredEvents;
  List<CleanupEvent> get volunteeredEvents => _volunteeredEvents;

  Future initilize() async {
    setIsLoading(true);

    var results = await Future.wait([
      _firestoreService.getUsersCreatedEvents(
        uid: _authenticationService.currentUser.uid,
      ),
      _firestoreService.getUsersVolunteeredEvents(
        uid: _authenticationService.currentUser.uid,
      )
    ]);
    setIsLoading(false);

    if (results[0] is List) {
      _createdEvents = results[0];
    }
    if (results[1] is List) {
      _volunteeredEvents = results[1];
    }
  }

  String getDistance(CleanupEvent event) {
    return _locationService.getDistance(
      latitude: event.position.latitude,
      longitude: event.position.longitude,
    );
  }

  void navigateToEvent(CleanupEvent _event) {
    _navigationService.navigateTo(
      EventDetailsScreenRoute,
      arguments: _event,
    );
  }
}
