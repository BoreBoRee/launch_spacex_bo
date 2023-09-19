import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:launch_spacex/dataprovider_api/spaceX_data_provider.dart';
import 'package:launch_spacex/more_information/model/rocket_model.dart';

class RocketRepository {
  final SpaceXDataProvider rocketRepository = SpaceXDataProvider();
  Future<dynamic> getOneRocketRepo(id) async {
    final http.Response rawOneRocket = await rocketRepository.getOneRocket(id);
    final json = jsonDecode(rawOneRocket.body);
    var oneRocket = Rocket(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      image: json['flickr_images'][0] ?? "",
    );
    return oneRocket;
  }
}
