import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CrewInformation extends Equatable {
  String? name;
  String? agency;
  String? image;
  String? id;
  CrewInformation({
    this.name = '',
    this.agency = '',
    this.image = '',
    this.id = '',
  });
  CrewInformation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    agency = json['agency'];
    image = json['image'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['agency'] = agency;
    data['image'] = image;
    data['id'] = id;

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
