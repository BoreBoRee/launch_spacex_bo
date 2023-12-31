import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/more_information/repository/rocket_repository.dart';
import 'package:launch_spacex/homepage_and_table/repository/spaceX_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
      ChildRoute(
        '/homepage',
        child: (context) => const Homepage(),
      ),
      ChildRoute('/launch-table', child: (context) => const LaunchTable()),
      ChildRoute('/launch-info',
          child: (context) => LaunchInformation(launchProgram: r.args.data)),
      ChildRoute('/setting', child: (context) => const Setting()),
    ]);
  }
}

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
