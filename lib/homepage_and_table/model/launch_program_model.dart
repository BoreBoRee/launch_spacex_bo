import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LaunchProgram extends Equatable {
  String? name;
  Map<String, dynamic>? image;
  String? success;
  List<dynamic>? crew;
  String? rocket;
  String? id;
  String? launchpad;
  String? launchpadImage;
  // ignore: non_constant_identifier_names
  String? date_utc;
  String? landPad;
  LaunchProgram({
    this.landPad = '',
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
    landPad = json['landpad'];
    name = json['name'];
    image = json['links']['patch'];
    success = json['success'];
    crew = json['crew'];
    id = json['id'];
    rocket = json['rocket'];
    launchpad = json['launchpad'];
    launchpadImage = json['launchpadImage'];
    date_utc = json['date_utc'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['landpad'] = landPad;
    data['name'] = name;
    data['links']['patch'] = image;
    data['success'] = success;
    data['crew'] = crew;
    data['id'] = id;
    data['rocket'] = rocket;
    data['launchpad'] = launchpad;
    data['date_utc'] = date_utc;

    return data;
  }

  @override
  List<Object?> get props => [
        landPad,
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
