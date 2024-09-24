// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BlogModel {
  final int? b_id;
  final String? title;
  final String? post;

  BlogModel(this.b_id, this.title, this.post);

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      map['b_id'] != null ? map['b_id'] as int : null,
      map['title'] != null ? map['title'] as String : '',
      map['post'] != null ? map['post'] as String : '',
    );
  }
}
