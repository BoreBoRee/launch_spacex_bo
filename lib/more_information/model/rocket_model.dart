// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Rocket extends Equatable {
  String? name;
  String? image;
  String? id;
  String? description;

  Rocket({
    this.name = '',
    this.description = '',
    this.image = '',
    this.id = '',
  });
  Rocket.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['id'] = id;
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
