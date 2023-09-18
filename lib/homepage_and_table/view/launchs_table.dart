import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../bloc/launch_bloc.dart';

class LaunchTable extends StatefulWidget {
  const LaunchTable({Key? key}) : super(key: key);

  @override
  State<LaunchTable> createState() => _LaunchTableState();
}

class _LaunchTableState extends State<LaunchTable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff333333),
        appBar: AppBar(
            backgroundColor: const Color(0xff333333),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Modular.to.navigate('/homepage'),
            ),
            title: const Text("app.launchTable").tr()),
        body: BlocConsumer<SpaceXBloc, SpaceXState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (kDebugMode) {
                print(state);
              }
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!state.loading && state.listLaunch.isNotEmpty) {
                var launchList = state.listLaunch;
                return TableWidget(launchList: launchList);
              } else {
                return const Center(
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
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
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
    String hintText = "filter.search".tr();
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      /// Search Bar
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: textController,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintStyle: const TextStyle(color: Colors.white),
              labelText: hintText,
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "filter.dateSorting".tr(),
              style: const TextStyle(color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSortDate = !_isSortDate;
                  items = items.reversed.toList();
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 15, left: 10),
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
                  _isSortDate
                      ? "filter.date".tr() + "↑"
                      : "filter.date".tr() + "↓",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "filter.nameSorting".tr(),
              style: const TextStyle(color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSortName++;
                  if (_isSortName == 1) {
                    items.sort((a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                  } else if (_isSortName == 2) {
                    items = items.reversed.toList();
                    _isSortName = 0;
                  } else if (_isSortName == 0) {
                    items = originalList!;
                    // _isSortName = 0;
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 15, left: 10),
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
                child: Center(
                    child: Text(
                  (_isSortName == 0)
                      ? "${"filter.name".tr()}↓"
                      : (_isSortName == 1)
                          ? "${"filter.name".tr()} ↑"
                          : "${"filter.name".tr()} ↓",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "filter.clear".tr(),
              style: const TextStyle(color: Colors.white),
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
                margin: const EdgeInsets.only(top: 15, left: 10),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  "filter.clearFilter".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
              return GestureDetector(
                  onTap: () {
                    Modular.to
                        .pushNamed('/launch-info', arguments: items[index]);
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
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Image.network(
                                      items[index].image['small'].toString(),
                                      fit: BoxFit.cover,
                                    )),

                                /// Mission Information
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: screenSize.width * 0.38,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].name.toString()),
                                        Text(
                                            "Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(items[index].date_utc.toString()))}")
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
                            (items[index].success == "null")
                                ? "app.noData".tr()
                                : (items[index].success.toString() == "true")
                                    ? "app.success".tr()
                                    : "app.failed".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    ]));
  }
}
