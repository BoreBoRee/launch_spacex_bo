import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget latestLaunchWidget() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.15,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Container(
            width: screenSize.width * 0.25,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey,
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

  Widget launchListView() {
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
            child: Text(""),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: AppBar(title: const Text("Homepage")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            topicTextWidget("Latest Launch"),
            latestLaunchWidget(),
            topicTextWidget("Launches"),
            launchListView(),
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
      ),
    );
  }
}
