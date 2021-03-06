import 'package:get_it/get_it.dart';
import 'core/services/database.dart';
import 'core/viewmodels/inventory.dart';

// Use get_it to locate services in our app
// allows decoupling of interface from inplementation
GetIt locator = GetIt.instance; // NOTE: GetIt is singleton

// Register objects
void setupLocator() {
  locator.registerLazySingleton(() => Database('inventory'));
  locator.registerLazySingleton(() => Inventory());
}
