import 'package:equatable/equatable.dart';

class LaunchProgram extends Equatable {
  String? name;
  Map<String, dynamic>? image;
  String? success;
  List<dynamic>? crew;
  String? rocket;
  String? id;
  String? launchpad;
  String? launchpadImage;
  String? date_utc;
  String? landpad;
  LaunchProgram({
    this.landpad = '',
    this.name = '',
    this.image = const {},
    this.success = '',
    this.crew = const [],
    this.id = '',
    this.rocket = '',
    this.launchpad = '',
    this.launchpadImage = '',
    this.date_utc = '',
  });
  LaunchProgram.fromJson(Map<String, dynamic> json) {
    landpad = json['landpad'];
    name = json['name'];
    image = json['links']['patch'];
    success = json['success'];
    crew = json['crew'];
    id = json['id'];
    rocket = json['rocket'];
    // capsules = json['capsules'];
    // payloads = json['payloads'];
    launchpad = json['launchpad'];
    launchpadImage = json['launchpadImage'];
    date_utc = json['date_utc'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['landpad'] = this.landpad;
    data['name'] = this.name;
    data['links']['patch'] = this.image;
    data['success'] = this.success;
    data['crew'] = this.crew;
    data['id'] = this.id;
    data['rocket'] = this.rocket;
    // data['capsules'] = this.capsules;
    // data['payloads'] = this.payloads;
    data['launchpad'] = this.launchpad;
    // data['launchpadImage'] = this.launchpadImage;
    data['date_utc'] = this.date_utc;

    return data;
  }

  @override
  List<Object?> get props => [
        landpad,
        name,
        image,
        success,
        crew,
        id,
        rocket,
        launchpad,
        launchpadImage,
        date_utc,
      ];
}
