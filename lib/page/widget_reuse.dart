import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import 'launch_info.dart';

Widget latestLaunchWidget(state, context) {
  String url = state.launchpadImage.toString();
  var screenSize = MediaQuery.of(context).size;
  return Container(
    width: screenSize.width,
    height: screenSize.height * 0.2,
    decoration: BoxDecoration(
        // color: Colors.white,
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(Radius.circular(8))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Container(
          width: screenSize.width * 0.25,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
        )
      ],
    ),
  );
}

Widget topicTextWidget(text, color) {
  return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text.toString(),
          style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ));
}

Widget launchListView(launch, context) {
  /// sort are here
  // print(launch[0].image.toString());
  List sortedLaunch = launch;
  // print(launch[0].date_utc.toString());
  // sortedLaunch.sort((a, b) => b.date_utc.compareTo(a.date_utc));
  // print(unsortedLaunch[0].date_utc.toString());

//
// // Send object
//   Modular.to.navigate('/second', arguments: Person());
  print(launch[0].image['small'].toString());
  var screenSize = MediaQuery.of(context).size;
  return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Modular.to.navigate('/launch-info', arguments: launch[index].id);
            },
            child: Container(
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Image.network(
                                    sortedLaunch[index]
                                        .image['small']
                                        .toString(),
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
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Text((launch[index].success == "null")
                        ? "No Data"
                        : launch[index].success.toString()),
                  )
                ],
              ),
            ));
      });
}
