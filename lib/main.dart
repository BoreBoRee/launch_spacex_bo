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

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child("/", child: (context) => Homepage(), children: [
      ChildRoute('/launch-table', child: (_) => LaunchTable()),
      ChildRoute('/launch-info',
          child: (_) => LaunchInformation(launchProgram: r.args.data)),
    ]);
  }
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SpaceXBloc(SpaceXRepository())..add(LaunchRequest()),
          ),
          BlocProvider(
              create: (context) => InformationBloc(LaunchOneRepository(),
                  CrewRepository(), PadsRepository(), RocketRepository())),
        ],
        child: MaterialApp.router(
          title: 'My Smart App',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: Modular.routerConfig,
        )); //added by extension
  }
}
