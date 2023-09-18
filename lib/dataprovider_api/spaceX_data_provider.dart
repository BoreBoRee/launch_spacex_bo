import 'package:http/http.dart' as http;

class SpaceXDataProvider {
  /// Get the latest launch data from the SpaceX API
  Future<http.Response> getRawLatestLaunch() async {
    String url = "https://api.spacexdata.com/latest/launches/latest";

    http.Response reqLatestLaunchData = await http.get(
      Uri.parse(url),
    );
    return reqLatestLaunchData;
  }

  /// Get all launch data from the SpaceX API
  Future<http.Response> getRawAllLaunch() async {
    String url = "https://api.spacexdata.com/v4/launches";
    http.Response rawAllLaunchData = await http.get(
      Uri.parse(url),
    );
    return rawAllLaunchData;
  }

  /// Get all launchpad data from the SpaceX API
  Future<http.Response> getRawLaunchPad(id) async {
    String url = "https://api.spacexdata.com/v4/launchpads/$id";
    http.Response rawLaunchPadData = await http.get(
      Uri.parse(url),
    );
    return rawLaunchPadData;
  }

  /// Get all rocket data from the SpaceX API
  Future<http.Response> getRawCrew(id) async {
    String url = "https://api.spacexdata.com/v4/crew/$id";
    http.Response rawCrewData = await http.get(
      Uri.parse(url),
    );
    return rawCrewData;
  }

  /// Get one land pad
  Future<http.Response> getRawLandPad(id) async {
    String url = "https://api.spacexdata.com/v4/landpads?query=$id";
    http.Response rawLandPadData = await http.get(
      Uri.parse(url),
    );
    return rawLandPadData;
  }

  /// Get one launch
  Future<http.Response> getOneLaunch(id) async {
    String url = "https://api.spacexdata.com/v4/launches/$id";
    return await http.get(Uri.parse(url));
  }

  /// Get one rocket
  Future<http.Response> getOneRocket(id) async {
    String url = "https://api.spacexdata.com/v4/rockets/$id";
    return await http.get(Uri.parse(url));
  }
}

/// Launchpad: https://api.spacexdata.com/v4/launchpads/:ID
/// Land https://api.spacexdata.com/v4/landpads?query=:ID
/// Crew https://api.spacexdata.com/v4/crew/:ID
