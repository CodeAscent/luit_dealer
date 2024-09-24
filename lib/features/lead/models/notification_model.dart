// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  final int id;
  final String name;
  final String subtitle;
  final String image;

  NotificationModel(this.id, this.name, this.subtitle, this.image);


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'image': image,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      map['id'] as int,
      map['name'] as String,
      map['subtitle'] as String,
      map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
