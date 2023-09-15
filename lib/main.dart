import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/data/space_x_repository.dart';
import 'package:launch_spacex/page/launchs_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/info_bloc/information_bloc.dart';
import 'bloc/launch_bloc/launch_bloc.dart';
import 'page/homepage.dart';
import 'page/launch_info.dart';

//
void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child("/", child: (context) => Homepage());
    r.child("/launch-table", child: (context) => LaunchTable());
    r.child("/launch-info",
        child: (context) => LaunchInformation(id: r.args.data));
    // ChildRoute('/launch-info',
    //     child: (_) => LaunchInformation(id: r.args.data));
  }
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // create: (context) => SpaceXBloc()..add(LaunchRequest()),
        providers: [
          BlocProvider(
            create: (context) =>
                SpaceXBloc(SpaceXRepository())..add(LaunchRequest()),
          ),
          BlocProvider(
              create: (context) =>
                  InformationBloc(InformationFetchRepository())),
        ],
        child: MaterialApp.router(
          title: 'My Smart App',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: Modular.routerConfig,
        )); //added by extension
  }
}
