import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dataprovider_api/spaceX_data_provider.dart';
import '../model/launch_program_model.dart';

class SpaceXRepository {
  final SpaceXDataProvider spaceXDataProvider = SpaceXDataProvider();

  /// Get Latest Launch
  Future<dynamic> getLatestLaunch() async {
    final http.Response rawLatestLaunch;
    try {
      rawLatestLaunch = await spaceXDataProvider.getRawLatestLaunch();
      final json = jsonDecode(rawLatestLaunch.body);
      final jsonLaunchPad =
          await spaceXDataProvider.getRawLaunchPad(json['launchpad']);
      String imageLaunchPad =
          jsonDecode(jsonLaunchPad.body)['images']['large'][0];
      var latestLaunch = LaunchProgram(
        rocket: json['rocket'] ?? "",
        id: json['id'].toString(),
        name: json['name'] ?? "",
        image: json['links']['patch'] ?? "",
        success: json['success'].toString(),
        crew: json['crew'] ?? "",
        landPad: json['cores'][0]['landpad'] ?? "not found",
        launchpad: json['launchpad'] ?? "",
        launchpadImage: imageLaunchPad,
        dateUtc: json['date_utc'] ?? "",
      );
      return latestLaunch;
    } catch (e) {
      rethrow;
    }
  }

  /// Get Launch List
  Future<dynamic> getLaunchList() async {
    final http.Response rawLaunchList =
        await spaceXDataProvider.getRawAllLaunch();
    final json = jsonDecode(rawLaunchList.body);
    List<LaunchProgram> launchList = [];
    for (int i = 0; i < json.length; i++) {
      var launchProgram = LaunchProgram(
        rocket: json[i]['rocket'] ?? "",
        id: json[i]['id'].toString(),
        name: json[i]['name'] ?? "",
        image: json[i]['links']['patch'] ?? "",
        success: json[i]['success'].toString(),
        crew: json[i]['crew'] ?? "",
        landPad: json[i]['cores'][0]['landpad'] ?? "",
        launchpad: json[i]['launchpad'] ?? "",
        launchpadImage: "",
        dateUtc: json[i]['date_utc'] ?? "",
      );
      launchList.add(launchProgram);
    }

    return launchList;
  }
}
