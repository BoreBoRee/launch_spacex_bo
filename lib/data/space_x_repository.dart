import 'dart:convert';
import 'package:http/http.dart' as http;
import 'space_x_data_provider.dart';
import 'models/launch.dart';

class SpaceXRepository {
  final SpaceXDataProvider spaceXDataProvider = SpaceXDataProvider();

  /// Get Latest Launch
  Future<dynamic> getLatestLaunch() async {
    print("Geting Data");
    final http.Response rawLatestLaunch;
    try {
      rawLatestLaunch = await spaceXDataProvider.getRawLatestLaunch();
      final json = jsonDecode(rawLatestLaunch.body);
      final jsonLaunchPad =
          await spaceXDataProvider.getRawLaunchPad(json['launchpad']);
      String imageLaunchPad =
          jsonDecode(jsonLaunchPad.body)['images']['large'][0];
      print("Res: ${imageLaunchPad}");
      var latestLaunch = LaunchProgram(
        rocket: json['rocket'] ?? "",
        id: json['id'].toString() ?? "",
        name: json['name'] ?? "",
        image: json['links']['patch'] ?? "",
        success: json['success'].toString() ?? "",
        crew: json['crew'] ?? "",
        landpad: json['cores'][0]['landpad'] ?? "not found",
        launchpad: json['launchpad'] ?? "",
        launchpadImage: imageLaunchPad ?? "",
        date_utc: json['date_utc'] ?? "",
      );
      print("Load latestLaunch complete");
      return latestLaunch;
    } catch (e) {
      print("Error: $e");
      // rawLatestLaunch = null;
    }

    // todo: map data from api to model
  }

  /// Get Launch List
  Future<dynamic> getLaunchList() async {
    final http.Response rawLaunchList =
        await spaceXDataProvider.getRawAllLaunch();
    final json = jsonDecode(rawLaunchList.body);
    List<LaunchProgram> launchList = [];
    print("Geting List launch");
    for (int i = 0; i < json.length; i++) {
      var launchProgram = LaunchProgram(
        rocket: json[i]['rocket'] ?? "",
        id: json[i]['id'].toString() ?? "",
        name: json[i]['name'] ?? "",
        image: json[i]['links']['patch'] ?? "",
        success: json[i]['success'].toString() ?? "",
        crew: json[i]['crew'] ?? "",
        landpad: json[i]['cores'][0]['landpad'] ?? "",
        launchpad: json[i]['launchpad'] ?? "",
        launchpadImage: "",
        date_utc: json[i]['date_utc'] ?? "",
      );
      launchList.add(launchProgram);
    }
    ;
    print("Load launchList complete");
    return launchList;
  }
}

class InformationFetchRepository {
  final SpaceXDataProvider informationSpaceXDataProvider = SpaceXDataProvider();
  Future<dynamic> getOneLaunchRepo(id) async {
    print("Getting Data one launch");
    final http.Response rawOneLaunch =
        await informationSpaceXDataProvider.getOneLaunch(id);
    final json = jsonDecode(rawOneLaunch.body);
    if (rawOneLaunch == "No Data") {
      return LaunchProgram();
    } else {
      print('loading Information');
      var oneLaunch = LaunchProgram(
        rocket: json['rocket'] ?? "",
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        image: json['links']['patch'] ?? "",
        success: json['success'].toString() ?? "",
        crew: json['crew'] ?? "",
        launchpad: json['launchpad'] ?? "",
        landpad: json['landpad'] ?? "",
        launchpadImage: "",
        date_utc: json['date_utc'] ?? "",
      );
      print("Load oneLaunch complete");
      return oneLaunch;
    }
  }

  Future<dynamic> getLaunchPadAndLandPadRepo(launch, land) async {
    print("Getting Land and Launch Pad");
    print("Geting Data launchPad id: $launch");
    final http.Response rawLaunchPad =
        await informationSpaceXDataProvider.getRawLaunchPad(launch);
    final jsonLaunch = jsonDecode(rawLaunchPad.body);
    List<LaunchPad> pad = [];
    var launchPad = LaunchPad(
      id: jsonLaunch['id'] ?? "",
      name: jsonLaunch['name'] ?? "",
      fullName: jsonLaunch['full_name'] ?? "",
      locality: jsonLaunch['locality'] ?? "",
      region: jsonLaunch['region'] ?? "",
      timezone: jsonLaunch['timezone'] ?? "",
      status: jsonLaunch['status'] ?? "",
      details: jsonLaunch['details'] ?? "",
      image: jsonLaunch['images']['large'][0] ?? "",
    );
    pad.add(launchPad);
    print("Load launchPad complete");
    print("Geting Data landPad id: $land");
    if (land == "No data" || land == null || land == "") {
      print("No data landPad");
      // var landpad = LaunchPad();
      pad.add(LaunchPad());
      return pad;
    } else {
      final http.Response rawLandPad =
          await informationSpaceXDataProvider.getRawLaunchPad(land);
      final json = jsonDecode(rawLandPad.body);
      var landPad = LaunchPad(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        fullName: json['full_name'] ?? "",
        locality: json['locality'] ?? "",
        region: json['region'] ?? "",
        timezone: json['timezone'] ?? "",
        status: json['status'] ?? "",
        details: json['details'] ?? "",
        image: json['images']['large'][0] ?? "",
      );
      print("Load landPad complete");
      pad.add(landPad);
      return pad;
    }
  }

  Future<dynamic> getCrewInformationRepo(ids) async {
    print("Getting Get infomration crew");
    List<CrewInformation> crewInformation = [];
    if (ids == null || ids == "") {
      print("No data crew");
      return CrewInformation();
    }
    for (var id in ids) {
      print("Getting crew id: $id");
      final http.Response rawCrewInformation =
          await informationSpaceXDataProvider.getRawCrew(id);
      final json = jsonDecode(rawCrewInformation.body);
      var crew = CrewInformation(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        agency: json['agency'] ?? "",
        image: json['image'] ?? "",
      );
      crewInformation.add(crew);
    }
    print("Load crewInformation complete");
    return crewInformation;
  }

  Future<dynamic> getOneRocketRepo(id) async {
    print("Getting Get infomration rocket");
    final http.Response rawOneRocket =
        await informationSpaceXDataProvider.getOneRocket(id);
    final json = jsonDecode(rawOneRocket.body);
    var oneRocket = Rocket(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      image: json['flickr_images'][0] ?? "",
    );
    print("Load oneRocket complete");
    return oneRocket;
  }
}
