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
        name: json['name'] ?? "",
        image: json['links']['patch'] ?? "",
        success: json['success'].toString() ?? "",
        crew: json['crew'] ?? "",
        // capsules: json['capsules'] ?? "",
        // payloads: json['payloads'] ?? "",
        launchpad: json['launchpad'] ?? "",
        launchpadImage: imageLaunchPad ?? "",
        flight_number: json['flight_number'] ?? "",
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
    List launchList = [];
    for (int i = 0; i < json.length; i++) {
      var launchProgram = LaunchProgram(
        name: json[i]['name'] ?? "",
        image: json[i]['links']['patch'] ?? "",
        success: json[i]['success'].toString() ?? "",
        crew: json[i]['crew'] ?? "",
        // capsules: json['capsules'] ?? "",
        // payloads: json['payloads'] ?? "",
        launchpad: json[i]['launchpad'] ?? "",
        launchpadImage: "",
        flight_number: json[i]['flight_number'] ?? "",
        date_utc: json[i]['date_utc'] ?? "",
      );
      launchList.add(launchProgram);
    }
    ;
    print("Load launchList complete");
    return launchList;
  }
}
