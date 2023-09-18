import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: (state.success.toString() == "true")
                  ? Text(
                      "app.success".tr(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade400),
                    )
                  : Text("app.failed".tr(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade400)),
            )
          ],
        ),
      ));
}
