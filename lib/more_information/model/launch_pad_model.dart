import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
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

  LaunchPad({
    this.name = '',
    this.fullName = '',
    this.locality = '',
    this.region = '',
    this.timezone = '',
    this.details = '',
    this.status = '',
    this.id = '',
    this.image = '',
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['full_name'] = fullName;
    data['locality'] = locality;
    data['region'] = region;
    data['timezone'] = timezone;
    data['details'] = details;
    data['status'] = status;
    data['id'] = id;
    data['image'] = image;
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
