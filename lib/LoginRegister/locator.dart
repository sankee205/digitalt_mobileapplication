import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/Services/dialogService.dart';
import 'package:digitalt_application/Services/firestoreService.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirestoreService());
}
