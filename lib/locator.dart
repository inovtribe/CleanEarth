import 'package:get_it/get_it.dart';
import 'package:timwan/services/authentication_service.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/services/location_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => LocationService());
}
