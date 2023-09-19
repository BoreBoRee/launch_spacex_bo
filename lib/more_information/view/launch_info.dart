// ignore_for_file: unrelated_type_equality_checks, use_full_hex_values_for_flutter_colors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:launch_spacex/homepage_and_table/model/launch_program_model.dart';
import 'package:launch_spacex/more_information/bloc/information_bloc.dart';
import 'package:launch_spacex/more_information/model/crew_model.dart';
import 'package:launch_spacex/utils/text_align_left.dart';

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
                print("Crew: ${state.crew}");
                var screenSize = MediaQuery.of(context).size;
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
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.all(10),
                            width: screenSize.width * 0.15,
                            height: screenSize.width * 0.15,
                            decoration: BoxDecoration(

                                // color: Colors.grey,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: (state.launch.image!['large'].toString() !=
                                    "null")
                                ? Image.network(
                                    state.launch.image!['large'].toString(),
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.close_rounded, size: 30),
                                      const Text(
                                        "app.noPicture",
                                        style: TextStyle(fontSize: 10),
                                      ).tr()
                                    ],
                                  ))),
                      ),
                      Text(state.rocket.name.toString()),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: topicTextWidget(
                              "information.crew", Colors.black)),
                      (state.crew[0].name != "")
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
                          : Center(
                              child: const Text("information.noCrew").tr()),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: topicTextWidget(
                              "information.mission", Colors.black)),
                      Text(state.launch.name.toString()),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: topicTextWidget(
                              "information.detail", Colors.black)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
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
