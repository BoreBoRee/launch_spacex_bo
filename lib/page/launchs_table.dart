import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:intl/intl.dart';
import '../bloc/launch_bloc.dart';

class LaunchTable extends StatefulWidget {
  const LaunchTable({Key? key}) : super(key: key);

  @override
  State<LaunchTable> createState() => _LaunchTableState();
}

class _LaunchTableState extends State<LaunchTable> {
  bool _isSort = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff333333),
        appBar: AppBar(
            backgroundColor: Color(0xff333333),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Modular.to.navigate(
                '/',
              ),
            ),
            title: const Text("Launch Table")),
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
            List launchList = state.listLaunch;

            return SingleChildScrollView(
                child: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSort = !_isSort;
                          if (_isSort) {
                            launchList.sort((a, b) => b.date_utc.compareTo(a.date_utc));
                          } else if (_isSort == false) {
                            // launchList.clear();
                            launchList = state.listLaunch;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15, left: 10),
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: _isSort ? Colors.white : Colors.orange,
                          border: Border.all(
                              color: _isSort ? Colors.white : Colors.orange,
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          _isSort ? "Sort by date" : "Original",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SearchBarAnimation(
                      searchBoxBorderColour: Colors.black,
                      searchBoxColour: Colors.black,
                      buttonColour: Colors.black,
                      cursorColour: Colors.white,
                      textEditingController: _textController,
                      isOriginalAnimation: true,
                      isSearchBoxOnRightSide: true,
                      enableKeyboardFocus: true,
                      onExpansionComplete: () {
                        debugPrint(
                            'do something just after searchbox is opened.');
                      },
                      onCollapseComplete: () {
                        debugPrint(
                            'do something just after searchbox is closed.');
                      },
                      onPressButton: (isSearchBarOpens) {
                        debugPrint(
                            'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                      },
                      trailingWidget: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.white,
                      ),
                      secondaryButtonWidget: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                      buttonWidget: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  // height: 200,
                  width: screenSize.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: launchList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          height: screenSize.height * 0.1,
                          width: screenSize.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
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
                                                      color: Colors.grey,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: Image.network(
                                                launchList[index]
                                                    .image['small']
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              )),
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              width: screenSize.width * 0.38,
                                              height: double.infinity,
                                              child: Column(
                                                children: [
                                                  Text(launchList[index]
                                                      .name
                                                      .toString()),
                                                  Text(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.parse(
                                                            launchList[index]
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
                                child: Text(
                                    (launchList[index].success == "null")
                                        ? "No Data"
                                        : launchList[index].success.toString()),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ]),
            ));
          } else {
            return Center(
              child: Text("Something went wrong!"),
            );
          }
        }));
  }
}
