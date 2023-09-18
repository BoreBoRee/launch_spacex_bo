import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dataprovider_api/spaceX_data_provider.dart';
import '../../homepage_and_table/model/launch_program_model.dart';

class LaunchOneRepository {
  final SpaceXDataProvider launchOneRepo = SpaceXDataProvider();
  Future<LaunchProgram> getOneLaunchRepo(id) async {
    final http.Response rawOneLaunch = await launchOneRepo.getOneLaunch(id);
    final json = jsonDecode(rawOneLaunch.body);
    if (rawOneLaunch.toString() == "No Data") {
      return LaunchProgram();
    } else {
      var oneLaunch = LaunchProgram(
        rocket: json['rocket'] ?? "",
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        image: json['links']['patch'] ?? "",
        success: json['success'].toString(),
        crew: json['crew'] ?? "",
        launchpad: json['launchpad'] ?? "",
        landPad: json['landpad'] ?? "",
        launchpadImage: "",
        dateUtc: json['date_utc'] ?? "",
      );
      return oneLaunch;
    }
  }
}
