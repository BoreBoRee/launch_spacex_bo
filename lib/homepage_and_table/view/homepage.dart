import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../navigation.dart';
import '../bloc/launch_bloc.dart';
import 'widget_reuse.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff333333),
        appBar: AppBar(
            backgroundColor: const Color(0xff333333),
            leading: Container(),
            title: const Text("app.homepage").tr()),
        body: BlocConsumer<SpaceXBloc, SpaceXState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!state.loading && state.listLaunch.isNotEmpty) {
                return SingleChildScrollView(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      topicTextWidget("app.latestLaunches", Colors.white54),
                      latestLaunchWidget(state.latestLaunch, context),
                      topicTextWidget("app.launches", Colors.white54),

                      launchListView(state.listLaunch, context),
                      // Text(state.launch.launchpad.toString()),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            Modular.to.navigate('launch-table');
                          },
                          child: const Text("See More")),
                    ],
                  ),
                ));
              } else {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              }
            }));
  }
}
