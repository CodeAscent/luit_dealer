class DownlineTreeModel {
  int id;
  String? firstname;
  String? lastname;
  String mobileNo;
  String? membershipId;
  int refid;
  List<DownlineTreeModel>? referrals;

  DownlineTreeModel({
    required this.id,
    this.firstname,
    this.lastname,
    required this.mobileNo,
    this.membershipId,
    required this.refid,
    this.referrals,
  });

  factory DownlineTreeModel.fromJson(Map<String, dynamic> json) {
    return DownlineTreeModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      mobileNo: json['mobile_no'],
      membershipId: json['membership_id'],
      refid: json['refid'],
      referrals: json['referrals'] != null
          ? List<DownlineTreeModel>.from(
              json['referrals']
                  .map((referral) => DownlineTreeModel.fromJson(referral)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'mobile_no': mobileNo,
      'membership_id': membershipId,
      'refid': refid,
      'referrals': referrals != null
          ? referrals!.map((referral) => referral.toJson()).toList()
          : [],
    };
  }
}
