import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/page/launchs_table.dart';

import 'page/homepage.dart';

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
  }
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
