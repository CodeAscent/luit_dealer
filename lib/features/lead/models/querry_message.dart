// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuerryMessage {
  final String msg_type;
  final String message;
  final String created_at;

  QuerryMessage(this.msg_type, this.message, this.created_at);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msg_type': msg_type,
      'message': message,
      'created_at': created_at,
    };
  }

  factory QuerryMessage.fromMap(Map<String, dynamic> map) {
    return QuerryMessage(
      map['msg_type'] ?? '',
      map['message'] ?? '',
      map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuerryMessage.fromJson(String source) =>
      QuerryMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
