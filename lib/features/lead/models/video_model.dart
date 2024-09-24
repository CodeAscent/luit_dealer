import 'dart:convert';

class VideoModel {
  final int? v_id;
  final String? title;
  final String? link;
  final String? description;
  final String? created_at;
  final int? updated_by;

  VideoModel(this.v_id, this.title, this.link, this.description,
      this.created_at, this.updated_by);

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        json['v_id'],
        json['title'],
        json['link'],
        json['description'],
        json['created_at'],
        json['updated_by'],
      );
}
