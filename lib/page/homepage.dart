import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:launch_spacex/page/widget_reuse.dart';
import '../bloc/launch_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff333333),
        appBar: AppBar(title: const Text("Homepage")),
        body: BlocConsumer<SpaceXBloc, SpaceXState>(listener: (context, state) {
          if (state is SpaceXError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        }, builder: (context, state) {
          print(state);
          if (state is SpaceXInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SpaceXLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SpaceXLoaded) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  topicTextWidget("Latest Launch"),
                  latestLaunchWidget(state.latestLaunch, context),
                  topicTextWidget("Launches"),

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
                      child: Text("See More")),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Something went wrong!"),
            );
          }
        }));
  }
}
