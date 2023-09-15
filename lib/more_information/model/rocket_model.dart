import 'package:equatable/equatable.dart';

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
