import 'package:flutter/material.dart';

class LaunchTable extends StatefulWidget {
  const LaunchTable({Key? key}) : super(key: key);

  @override
  State<LaunchTable> createState() => _LaunchTableState();
}

class _LaunchTableState extends State<LaunchTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Launch Table")), body: Container());
  }
}
