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
          // if (state.loading == false) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("Any Error occured!")),
          //   );
          // }
        }, builder: (context, state) {
          print(state);
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!state.loading && state.listLaunch.isNotEmpty) {
            var launchList = state.listLaunch;
            var item = launchList;
            return TableWidget(launchList: launchList);
          } else {
            return Center(
              child: Text("Something went wrong!"),
            );
          }
        }));
  }
}

class TableWidget extends StatefulWidget {
  const TableWidget({Key? key, required this.launchList}) : super(key: key);
  final List launchList;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  bool _isSortDate = false;
  int _isSortName = 0;
  var items = [];
  List? originalList;
  TextEditingController textController = TextEditingController();
  ScrollController _controller = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = widget.launchList;

    originalList = widget.launchList;
  }

  void filterSearchResults(String query) {
    setState(() {
      items = widget.launchList
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    var screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: textController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Date Sorting",
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSortDate = !_isSortDate;
                    items = items.reversed.toList();
                    if (_isSortDate == true) {
                      // print("Sorted items");
                      items.sort((a, b) => b.date_utc.compareTo(a.date_utc));
                    } else if (_isSortDate == false) {
                      // launchList.clear();
                      // print('Unsorted items');
                      items = widget.launchList;
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 10),
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _isSortDate ? Colors.white : Colors.orange,
                    border: Border.all(
                        color: _isSortDate ? Colors.white : Colors.orange,
                        width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    _isSortDate ? "date ↑" : "date ↓",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Name Sorting",
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSortName++;
                    print("sorted name count = $_isSortName");
                    // if (_isSortName >= 3) {
                    //   items = originalList!;
                    //   // print(originalList);
                    //   print("origin by name");
                    //   _isSortName = 0;
                    // }
                    if (_isSortName == 1) {
                      items.sort((a, b) =>
                          a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                    } else if (_isSortName == 2) {
                      items = items.reversed.toList();
                      _isSortName = 0;
                    } else if (_isSortName == 0) {
                      items = originalList!;
                      print("origin by date");
                      // _isSortName = 0;
                    }

                    // items = items.reversed.toList();
                    // if (_isSortDate == true) {
                    //   // print("Sorted items");
                    //   // items.sort((a, b) => b.date_utc.compareTo(a.date_utc));
                    // } else if (_isSortDate == false) {
                    //   // launchList.clear();
                    //   // print('Unsorted items');
                    //   // items = widget.launchList;
                    // }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 10),
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: (_isSortName == 0)
                        ? Colors.white
                        : (_isSortName == 1)
                            ? Colors.orange
                            : Colors.blue,
                    border: Border.all(
                        color: (_isSortName == 0)
                            ? Colors.orange
                            : (_isSortName == 1)
                                ? Colors.black
                                : Colors.white54,
                        width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // ↑ → ↓ ↚ ↛ ↜ ↝ ↞ ↟
                  child: Center(
                      child: Text(
                    (_isSortName == 0)
                        ? "name ↓"
                        : (_isSortName == 1)
                            ? "name ↑"
                            : "name ↓",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Clear",
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSortDate = !_isSortDate;

                    items = widget.launchList;
                    _isSortDate = false;
                    _isSortName = 0;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 10),
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Clear filter",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ]),
        Container(
          margin: const EdgeInsets.all(10),
          // height: 200,
          width: screenSize.width,
          child: ListView.builder(
              controller: _controller,
              shrinkWrap: true,
              itemCount: items.length,
              scrollDirection: Axis.vertical,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Image.network(
                                        items[index].image['small'].toString(),
                                        fit: BoxFit.cover,
                                      )),
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      width: screenSize.width * 0.38,
                                      height: double.infinity,
                                      child: Column(
                                        children: [
                                          Text(items[index].name.toString()),
                                          Text(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(items[index]
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
                        child: Text((items[index].success == "null")
                            ? "No Data"
                            : items[index].success.toString()),
                      )
                    ],
                  ),
                );
              }),
        ),
      ]),
    ));
    ;
  }
}
