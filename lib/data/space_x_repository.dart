import 'dart:convert';
import 'package:http/http.dart' as http;
import 'space_x_data_provider.dart';
import 'models/launch.dart';

class SpaceXRepository {
  late final SpaceXDataProvider spaceXDataProvider;
  Future<dynamic> getLatestLaunch() async {
    final http.Response rawWeather =
        await spaceXDataProvider.getRawLatestLaunch();
    final json = jsonDecode(rawWeather.body);
    // final Launch launch = Launch.fromJson(json);
    // todo: map data from api to model
    return Launch;
  }
}
