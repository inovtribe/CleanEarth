import 'package:get_it/get_it.dart';
import 'package:timwan/services/firebase_auth_service.dart';
import 'package:timwan/services/firestore_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => FirebaseAuthService());
}
