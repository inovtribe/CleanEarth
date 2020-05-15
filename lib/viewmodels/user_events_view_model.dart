import 'package:timwan/locator.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class UserEventsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

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
}
