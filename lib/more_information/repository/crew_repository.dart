import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dataprovider_api/spaceX_data_provider.dart';
import '../model/crew_model.dart';

class CrewRepository {
  final SpaceXDataProvider crewDataRepo = SpaceXDataProvider();

  Future<dynamic> getCrewInformationRepo(ids) async {
    List<CrewInformation> crewInformation = [];
    if (ids.isEmpty) {
      return [
        CrewInformation(),
      ];
    }
    for (var id in ids) {
      final http.Response rawCrewInformation =
          await crewDataRepo.getRawCrew(id);
      final json = jsonDecode(rawCrewInformation.body);
      if (json['name'] == null) {
        return CrewInformation();
      } else {
        var crew = CrewInformation(
          id: json['id'] ?? "",
          name: json['name'] ?? "",
          agency: json['agency'] ?? "",
          image: json['image'] ?? "",
        );
        crewInformation.add(crew);
      }
    }
    return crewInformation;
  }
}
