import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dataprovider_api/spaceX_data_provider.dart';
import '../model/rocket_model.dart';

class RocketRepository {
  final SpaceXDataProvider rocketRepository = SpaceXDataProvider();
  Future<dynamic> getOneRocketRepo(id) async {
    print("Getting Get infomration rocket");
    final http.Response rawOneRocket = await rocketRepository.getOneRocket(id);
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
