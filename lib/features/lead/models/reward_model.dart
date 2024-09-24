class RewardModel {
  final int? rw_id;
  final int? points;
  final int? level;
  final String? received_at;

  RewardModel(this.rw_id, this.points, this.level, this.received_at);

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
        json['rw_id'],
        json['points'],
        json['level'],
        json['received_at'],
      );
}
