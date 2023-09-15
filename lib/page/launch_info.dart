import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget_reuse.dart';
import '../bloc/info_bloc/information_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
import 'navigate.dart';

class LaunchInformation extends StatefulWidget {
  const LaunchInformation({Key? key, required this.id}) : super(key: key);
  final id;

  @override
  State<LaunchInformation> createState() => _LaunchInformationState();
}

class _LaunchInformationState extends State<LaunchInformation> {
  @override
  Widget build(BuildContext context) {
    context.read<InformationBloc>().add(InformationRequest(id: widget.id));
    return Scaffold(
        backgroundColor: Color(0xff3333333),
        body: BlocConsumer<InformationBloc, InformationState>(
            listener: (context, state) {
          // if (state is InformationError) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.message),
          //     ),
          //   );
          // }
        }, builder: (context, state) {
          print(state);
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!state.loading && state.launch.id != null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        pop();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.arrow_back_ios)),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: topicTextWidget("Rocket", Colors.black)),
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 200,
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //     image: NetworkImage(
                        //         state.launch.image['large'].toString())),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image(
                        height: 200,
                        image: NetworkImage(
                            state.launch.image!['large'].toString())),
                  ),
                  Text(state.rocket.name.toString()),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: topicTextWidget("Crew", Colors.black)),
                  Text((state.crew.toString() != "[]") ? "Crew" : "No Crew"),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: topicTextWidget("Mission", Colors.black)),
                  Text(state.launch.name.toString()),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: topicTextWidget("Details", Colors.black)),
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
