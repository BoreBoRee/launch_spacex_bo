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

class LaunchPad extends Equatable {
  String? name;
  String? fullName;
  String? locality;
  String? region;
  String? timezone;
  String? details;
  String? status;
  String? id;
  String? image;

  LaunchPad(
      {this.name = '',
      this.fullName = '',
      this.locality = '',
      this.region = '',
      this.timezone = '',
      this.details = '',
      this.status = '',
      this.id = '',
      this.image = ''});
  LaunchPad.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fullName = json['full_name'];
    locality = json['locality'];
    region = json['region'];
    timezone = json['timezone'];
    details = json['details'];
    status = json['status'];
    id = json['id'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['locality'] = this.locality;
    data['region'] = this.region;
    data['timezone'] = this.timezone;
    data['details'] = this.details;
    data['status'] = this.status;
    data['id'] = this.id;
    data['image'] = this.image;

    return data;
  }

  @override
  List<Object?> get props => [
        name,
        fullName,
        locality,
        region,
        timezone,
        details,
        status,
        id,
        image,
      ];
}

class CrewInformation extends Equatable {
  String? name;
  String? agency;
  String? image;
  String? id;
  CrewInformation(
      {this.name = '', this.agency = '', this.image = '', this.id = ''});
  CrewInformation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    agency = json['agency'];
    image = json['image'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['agency'] = this.agency;
    data['image'] = this.image;
    data['id'] = this.id;

    return data;
  }

  @override
  List<Object?> get props => [
        name,
        agency,
        image,
        id,
      ];
}

class Rocket extends Equatable {
  String? name;
  String? image;
  String? id;
  String? description;

  Rocket(
      {this.name = '', this.description = '', this.image = '', this.id = ''});
  Rocket.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['id'] = this.id;

    return data;
  }

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        id,
      ];
}
