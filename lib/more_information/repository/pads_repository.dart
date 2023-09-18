import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:launch_spacex/dataprovider_api/spaceX_data_provider.dart';
import 'package:launch_spacex/more_information/model/launch_pad_model.dart';


class PadsRepository {
  Future<dynamic> launchRepository(launch) async {
    final SpaceXDataProvider getPadsRepo = SpaceXDataProvider();
    final http.Response rawLaunchPad =
        await getPadsRepo.getRawLaunchPad(launch);
    final jsonLaunch = jsonDecode(rawLaunchPad.body);
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
    return launchPad;
  }
}
