import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
              Modular.to.pushNamed('/launch-info', arguments: launch[index]);
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
                              child: (sortedLaunch[index]
                                          .image['small']
                                          .toString() !=
                                      "null")
                                  ? Image.network(
                                      sortedLaunch[index]
                                          .image['small']
                                          .toString(),
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(
                                      width: screenSize.width * 0.15,
                                      height: screenSize.width * 0.15,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.close_rounded,
                                              size: 30),
                                          const Text(
                                            "app.noPicture",
                                            style: TextStyle(fontSize: 10),
                                          ).tr()
                                        ],
                                      ))),
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
                                      "${"filter.date".tr()}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(sortedLaunch[index].date_utc.toString()))}")
                                ],
                              ))
                        ],
                      )),
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
                      (launch[index].success == "null")
                          ? "app.noData".tr()
                          : (launch[index].success.toString() == "true")
                              ? "app.success".tr()
                              : "app.failed".tr(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                ],
              ),
            ));
      });
}
