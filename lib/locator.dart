import 'package:get_it/get_it.dart';
import 'package:insta/services/firebase_auth_service.dart';
import 'package:insta/services/firebase_storage.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/searchservice.dart';

GetIt locator = GetIt.I; // GetIt.I -  GetIt.instance - nin kisaltmasidir

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => SearchService());
}
