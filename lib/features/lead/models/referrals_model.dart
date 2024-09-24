class ReferralsModel {
  final String? remarks;
  final String? updated_at;
  final LeadStatus? lead_status;
  final int? r_id;
  final String? delivered;
  final String? booking;
  final String? next_followup_date;
  final String? fullName;

  ReferralsModel(this.remarks, this.updated_at, this.lead_status, this.r_id,
      this.delivered, this.booking, this.next_followup_date, this.fullName);

  factory ReferralsModel.fromJson(Map<String, dynamic> json) => ReferralsModel(
      json['remarks'],
      json['updated_at'],
      LeadStatus.fromJson(
        json['lead_status'],
      ),
      json['r_id'],
      json['delivered'] == 0 ? 'YES' : 'NO',
      json['booking'] == 0 ? 'YES' : 'NO',
      json['next_followup_date'].toString(),
      json['user']['firstname'] ?? '' + ' ' + json['user']['lastname'] ?? '');
}

class LeadStatus {
  final String? title;
  final String? lead_status_color;

  LeadStatus(this.title, this.lead_status_color);

  factory LeadStatus.fromJson(Map<String, dynamic> json) =>
      LeadStatus(json['title'], json['lead_status_color']);
}
