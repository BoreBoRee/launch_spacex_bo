import 'package:get_it/get_it.dart';
import 'package:launch_spacex/notification/firebase_message.dart';

//..
GetIt locator = GetIt.instance;
//..
void setupLocator() {
  locator.registerLazySingleton(() => PushNotificationService());
}
