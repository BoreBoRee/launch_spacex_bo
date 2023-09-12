import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/page/launchs_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/launch_bloc.dart';
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
    r.child("/launch-table", child: (context) => LaunchTable(), children: [
      ChildRoute("/launch-info", child: (context) => LaunchInformation()),
    ]);
  }
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SpaceXBloc()..add(LaunchRequest()),
        child: MaterialApp.router(
          title: 'My Smart App',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: Modular.routerConfig,
        )); //added by extension
  }
}
