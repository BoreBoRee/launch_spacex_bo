import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
//
void main() {

  return runApp(ModularApp(module: /*<MainModule>*/, child: /*<MainWidget>*/));
}
class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {

  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'launch spaceX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    home: Container(),
    );
  }
}
