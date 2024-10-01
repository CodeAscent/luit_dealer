import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfile {
  num? id;
  String? deposit_amount;
  num? product_cat_id;
  String? product_cat_name;
  num? brand_id;
  String? brand_name;
  UserProfile({
    this.id,
    this.deposit_amount,
    this.product_cat_id,
    this.product_cat_name,
    this.brand_id,
    this.brand_name,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deposit_amount': deposit_amount,
      'product_cat_id': product_cat_id,
      'product_cat_name': product_cat_name,
      'brand_id': brand_id,
      'brand_name': brand_name,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] != null ? map['id'] as num : null,
      deposit_amount: map['deposit_amount'] != null ? map['deposit_amount'] as String : null,
      product_cat_id: map['product_cat_id'] != null ? map['product_cat_id'] as num : null,
      product_cat_name: map['product_cat_name'] != null ? map['product_cat_name'] as String : null,
      brand_id: map['brand_id'] != null ? map['brand_id'] as num : null,
      brand_name: map['brand_name'] != null ? map['brand_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
