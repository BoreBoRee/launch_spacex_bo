import 'package:equatable/equatable.dart';

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
