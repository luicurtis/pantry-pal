
import 'package:get_it/get_it.dart';
import 'core/services/database.dart';

// Use get_it to locate services in our app
// allows decoupling of interface from inplementation
GetIt locator = GetIt.instance; // NOTE: GetIt is singleton

// Register objects
void setupLoacator() {
  locator.registerLazySingleton(() => Database('inventory'));
}