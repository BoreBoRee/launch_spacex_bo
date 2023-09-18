import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

Widget latestLaunchWidget(state, context) {
  String url = state.launchpadImage.toString();
  var screenSize = MediaQuery.of(context).size;
  return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/launch-info', arguments: state);
      },
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.2,
        decoration: BoxDecoration(
            // color: Colors.white,
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenSize.width * 0.699,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              width: screenSize.width * 0.20,
                              child: Image(
                                  image: NetworkImage(
                                      state.image['small'].toString()))))),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8))),
                      width: screenSize.width * 0.699,
                      height: screenSize.height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            state.name.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(state.date_utc.toString())),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ]),
            Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.25,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: (state.success.toString() == "true")
                  ? Text(
                      "Success",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade400),
                    )
                  : Text("Failure",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade400)),
            )
          ],
        ),
      ));
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
        ).tr(),
      ));
}

Widget launchListView(launch, context) {
  /// sort are here
  List sortedLaunch = launch;
  sortedLaunch.sort((a, b) => b.date_utc.compareTo(a.date_utc));
  var screenSize = MediaQuery.of(context).size;
  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Modular.to
                  .pushNamed('/launch-info', arguments: sortedLaunch[index]);
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
                  SizedBox(
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Image.network(
                                sortedLaunch[index].image['small'].toString(),
                                fit: BoxFit.cover,
                              )),

                          /// Mission Information
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: screenSize.width * 0.38,
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sortedLaunch[index].name.toString()),
                                  Text(
                                      "Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(sortedLaunch[index].date_utc.toString()))}")
                                ],
                              ))
                        ],
                      )),

                  /// Success
                  Container(
                    alignment: Alignment.center,
                    width: screenSize.width * 0.20,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Text(
                      (sortedLaunch[index].success == "null")
                          ? "app.noData".tr()
                          : (sortedLaunch[index].success.toString() == "true")
                              ? "app.success".tr()
                              : "app.failed".tr(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                ],
              ),
            ));
      });
}
