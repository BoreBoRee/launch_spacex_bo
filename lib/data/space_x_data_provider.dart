import 'package:http/http.dart' as http;

class SpaceXDataProvider {
  /// Get the latest launch data from the SpaceX API
  Future<http.Response> getRawLatestLaunch() async {
    String url = "https://api.spacexdata.com/v4/launches/latest";
    http.Response reqLatestLaunchData = await http.get(
      Uri.parse("$url"),
    );
    return reqLatestLaunchData;
  }

  /// Get all launch data from the SpaceX API
  Future<http.Response> getRawAllLaunch() async {
    String url = "https://api.spacexdata.com/v4/launches";
    http.Response rawAllLaunchData = await http.get(
      Uri.parse("$url"),
    );
    return rawAllLaunchData;
  }

  /// Get all launchpad data from the SpaceX API
  Future<http.Response> getRawLaunchPad(id) async {
    String url = "https://api.spacexdata.com/v4/landpads?query=${id}";
    http.Response rawLaunchPadData = await http.get(
      Uri.parse("$url"),
    );
    return rawLaunchPadData;
  }

  /// Get all rocket data from the SpaceX API
  Future<http.Response> getRawCrew(id) async {
    String url = "https://api.spacexdata.com/v4/crew/${id}";
    http.Response rawCrewData = await http.get(
      Uri.parse("$url"),
    );
    return rawCrewData;
  }
}
