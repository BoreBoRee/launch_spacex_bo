import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/login/view/login_page.dart';
import 'package:launch_spacex/more_information/repository/rocket_repository.dart';
import 'package:launch_spacex/homepage_and_table/repository/spaceX_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_spacex/notification/firebase_message.dart';
import 'package:launch_spacex/notification/services/locator.dart';
import 'package:launch_spacex/notification/view/homapge_noti.dart';
import 'package:launch_spacex/notification/view/offerpage.dart';
import 'firebase_options.dart';
import 'homepage_and_table/view/homepage.dart';
import 'homepage_and_table/view/launchs_table.dart';
import 'more_information/bloc/information_bloc.dart';
import 'homepage_and_table/bloc/launch_bloc.dart';
import 'more_information/repository/crew_repository.dart';
import 'more_information/repository/launch_one_repository.dart';
import 'more_information/repository/pads_repository.dart';
import 'more_information/view/launch_info.dart';
import 'navigation.dart';
import 'setting/setting.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  setupLocator();

  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  log("FCMToken $fcmToken");
  return runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('th')],
        path: 'assets/lang',
        fallbackLocale: const Locale('th'),
        child: ModularApp(module: AppModule(), child: const AppWidget())),
  );
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const NavigationPage(), children: [
      // ChildRoute('/navGate',
      //     child: (context) => const NavigationPage(),
      //     children: [
      ChildRoute(
        '/homepage',
        child: (context) => const Homepage(),
      ),
      ChildRoute('/homepage-noti', child: (context) => const HomepageNoti()),
      ChildRoute('/offer-page', child: (context) => const OfferPage()),
      ChildRoute('/launch-table', child: (context) => const LaunchTable()),
      ChildRoute('/launch-info',
          child: (context) => LaunchInformation(launchProgram: r.args.data)),
      ChildRoute('/setting', child: (context) => const Setting()),
      //    ]
      // )
    ]);
  }
}

// void routes(r) {
//   r.child('/', child: (context) => const NavigationPage(), children: [
//     ChildRoute('/navGate', child: (context) => const  NavigationPage())
//     ChildRoute(
//       '/homepage',
//       child: (context) => const Homepage(),
//     ),
//     ChildRoute('/launch-table', child: (context) => const LaunchTable()),
//     ChildRoute('/launch-info',
//         child: (context) => LaunchInformation(launchProgram: r.args.data)),
//     ChildRoute('/setting', child: (context) => const Setting()),
//   ]);
// }
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SpaceXBloc(SpaceXRepository())..add(const LaunchRequest()),
          ),
          BlocProvider(
              create: (context) => InformationBloc(LaunchOneRepository(),
                  CrewRepository(), PadsRepository(), RocketRepository())),
        ],
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'SpaceX History',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: Modular.routerConfig,
        )); //added by extension
  }
}
