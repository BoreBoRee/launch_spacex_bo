import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        appBar: AppBar(title: const Text("Homepage")),
        body: BlocConsumer<SpaceXBloc, SpaceXState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!state.loading && state.listLaunch.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      topicTextWidget("Latest Launch", Colors.white54),
                      latestLaunchWidget(state.latestLaunch, context),
                      topicTextWidget("Launches", Colors.white54),

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
                );
              } else {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              }
            }));
  }
}
