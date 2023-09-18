import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/more_information/model/crew_model.dart';
import '../../homepage_and_table/model/launch_program_model.dart';
import '../../homepage_and_table/view/widget_reuse.dart';
import '../bloc/information_bloc.dart';

class LaunchInformation extends StatefulWidget {
  const LaunchInformation({Key? key, required this.launchProgram})
      : super(key: key);

  final LaunchProgram launchProgram;

  @override
  State<LaunchInformation> createState() => _LaunchInformationState();
}

class _LaunchInformationState extends State<LaunchInformation> {
  @override
  void initState() {
    BlocProvider.of<InformationBloc>(context)
        .add(InformationRequest(launchProgram: widget.launchProgram));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff3333333),
        body: BlocConsumer<InformationBloc, InformationState>(
            listener: (context, state) {},
            buildWhen: (previous, current) {
              if (previous.loading != current.loading) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!state.loading && state.launch.id != null) {
                return SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                            Modular.to.pushNamed(
                              '/homepage',
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(Icons.arrow_back_ios)),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: topicTextWidget(
                              "information.rocket".tr(), Colors.black)),
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image(
                            height: 200,
                            image: NetworkImage(
                                state.launch.image!['large'].toString())),
                      ),
                      Text(state.rocket.name.toString()),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: topicTextWidget(
                              "information.crew", Colors.black)),
                      (state.crew != CrewInformation())
                          ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.crew.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image(
                                            height: 100,
                                            image: NetworkImage(state
                                                .crew[index].image!
                                                .toString())),
                                      ),
                                      Text(state.crew[index].name.toString()),
                                    ],
                                  ),
                                );
                              })
                          : const Center(child: Text("No Crew")),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: topicTextWidget(
                              "information.mission", Colors.black)),
                      Text(state.launch.name.toString()),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: topicTextWidget(
                              "information.detail", Colors.black)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(state.rocket.description.toString()),
                      ),
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
