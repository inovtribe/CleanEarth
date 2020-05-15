import 'package:timwan/locator.dart';
import 'package:timwan/models/trash_report.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class UserReportsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<TrashReport> _createdReports;
  List<TrashReport> get createdReports => _createdReports;

  List<TrashReport> _cleanedReports;
  List<TrashReport> get cleanedReports => _cleanedReports;

  Future initilize() async {
    setIsLoading(true);

    var results = await Future.wait([
      _firestoreService.getUsersReports(
        uid: _authenticationService.currentUser.uid,
      ),
      _firestoreService.getUsersCleanedReports(
        uid: _authenticationService.currentUser.uid,
      )
    ]);
    setIsLoading(false);

    if (results[0] is List) {
      _createdReports = results[0];
    }
    if (results[1] is List) {
      _cleanedReports = results[1];
    }
  }
}
