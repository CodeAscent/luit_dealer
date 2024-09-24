// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QueryData {
  final int qId;
  final String subject;
  final int status;
  final DateTime updatedAt;
  final DateTime createdAt;

  QueryData({
    required this.qId,
    required this.subject,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  factory QueryData.fromJson(Map<String, dynamic> json) {
    return QueryData(
      qId: json['q_id'],
      subject: json['subject'],
      status: json['status'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'q_id': qId,
      'subject': subject,
      'status': status,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class QueryPageData {
  final int current_page;
  final int total;
  final List<QueryData> data;

  QueryPageData(this.current_page, this.total, this.data);

  factory QueryPageData.fromMap(Map<String, dynamic> map) {
    return QueryPageData(
      map['current_page'] ?? 1,
      map['total'] ?? 0,
      List<QueryData>.from(
        (map['data']).map(
          (x) => QueryData.fromJson(x),
        ),
      ),
    );
  }

  factory QueryPageData.fromJson(String source) =>
      QueryPageData.fromMap(json.decode(source) as Map<String, dynamic>);
}
