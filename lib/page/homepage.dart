import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../bloc/launch_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget latestLaunchWidget(state) {
    String url = state.launchpadImage.toString();
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.2,
      decoration: BoxDecoration(
          // color: Colors.white,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Container(
            width: screenSize.width * 0.25,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
          )
        ],
      ),
    );
  }

  Widget topicTextWidget(text) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget launchListView(launch) {
    /// sort are here
    // print(launch[0].image.toString());
    List sortedLaunch = launch;
    // print(launch[0].date_utc.toString());
    sortedLaunch.sort((a, b) => b.date_utc.compareTo(a.date_utc));
    // print(unsortedLaunch[0].date_utc.toString());
    print(launch[0].image['small'].toString());
    var screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: screenSize.height * 0.1,
            width: screenSize.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: SizedBox(
                        width: screenSize.width * 0.6,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(2),
                                margin: const EdgeInsets.all(10),
                                width: screenSize.width * 0.15,
                                height: screenSize.width * 0.15,
                                decoration: BoxDecoration(

                                    // color: Colors.grey,
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Image.network(
                                  sortedLaunch[index].image['small'].toString(),
                                  fit: BoxFit.cover,
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: screenSize.width * 0.38,
                                height: double.infinity,
                                child: Column(
                                  children: [
                                    Text(sortedLaunch[index].name.toString()),
                                    Text(
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(sortedLaunch[index]
                                              .date_utc
                                              .toString())),
                                    )
                                  ],
                                ))
                          ],
                        ))),
                Container(
                  width: screenSize.width * 0.20,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Text((launch[index].success == "null")
                      ? "No Data"
                      : launch[index].success.toString()),
                )
              ],
            ),
          );
        });
  }

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
                  latestLaunchWidget(state.latestLaunch),
                  topicTextWidget("Launches"),

                  launchListView(state.listLaunch),
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
