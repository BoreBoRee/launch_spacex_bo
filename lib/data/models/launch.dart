class LaunchProgram {
  String? name;
  Map<String, dynamic>? image;
  String? success;
  List<dynamic>? crew;
  // String? capsules;
  // String? payloads;
  String? launchpad;
  String? launchpadImage;
  int? flight_number;
  String? date_utc;

  LaunchProgram(
      {required this.name,
      required this.image,
      required this.success,
      required this.crew,
      // required this.capsules,
      // required this.payloads,
      required this.launchpad,
      required this.launchpadImage,
      required this.date_utc,
      required this.flight_number});
  LaunchProgram.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['links']['patch'];
    success = json['success'];
    crew = json['crew'];
    // capsules = json['capsules'];
    // payloads = json['payloads'];
    launchpad = json['launchpad'];
    launchpadImage = json['launchpadImage'];
    flight_number = json['flight_number'];
    date_utc = json['date_utc'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['links']['patch'] = this.image;
    data['success'] = this.success;
    data['crew'] = this.crew;
    // data['capsules'] = this.capsules;
    // data['payloads'] = this.payloads;
    data['launchpad'] = this.launchpad;
    // data['launchpadImage'] = this.launchpadImage;
    data['flight_number'] = this.flight_number;
    data['date_utc'] = this.date_utc;

    return data;
  }
}

//{
//   "fairings": null,
///   "links": {
//     "patch": {
///       "small": "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png",
///       "large": "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png"
//     },
//     "reddit": {
//       "campaign": null,
//       "launch": "https://www.reddit.com/r/spacex/comments/xvm76j/rspacex_crew5_launchcoast_docking_discussion_and/",
//       "media": null,
//       "recovery": null
//     },
//     "flickr": {
//       "small": [],
//       "original": []
//     },
//     "presskit": null,
//     "webcast": "https://youtu.be/5EwW8ZkArL4",
//     "youtube_id": "5EwW8ZkArL4",
//     "article": null,
//     "wikipedia": "https://en.wikipedia.org/wiki/SpaceX_Crew-5"
//   },
//   "static_fire_date_utc": null,
//   "static_fire_date_unix": null,
//   "net": false,
//   "window": null,
//   "rocket": "5e9d0d95eda69973a809d1ec",
///   "success": true,
///   "failures": [],
///   "details": null,
///   "crew": [
///     "62dd7196202306255024d13c",
///     "62dd71c9202306255024d13d",
///     "62dd7210202306255024d13e",
///     "62dd7253202306255024d13f"
///   ],
//   "ships": [],
///   "capsules": [
///     "617c05591bad2c661a6e2909"
///   ],
///   "payloads": [
///     "62dd73ed202306255024d145"
///   ],
///   "launchpad": "5e9e4502f509094188566f88",
///   "flight_number": 187,
///   "name": "Crew-5",
///   "date_utc": "2022-10-05T16:00:00.000Z",
//   "date_unix": 1664985600,
//   "date_local": "2022-10-05T12:00:00-04:00",
//   "date_precision": "hour",
//   "upcoming": false,
//   "cores": [
//     {
//       "core": "633d9da635a71d1d9c66797b",
//       "flight": 1,
//       "gridfins": true,
//       "legs": true,
//       "reused": false,
//       "landing_attempt": true,
//       "landing_success": true,
//       "landing_type": "ASDS",
//       "landpad": "5e9e3033383ecbb9e534e7cc"
//     }
//   ],
//   "auto_update": true,
//   "tbd": false,
//   "launch_library_id": "f33d5ece-e825-4cd8-809f-1d4c72a2e0d3",
//   "id": "62dd70d5202306255024d139"
// }
