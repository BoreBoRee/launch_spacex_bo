import 'package:equatable/equatable.dart';

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
