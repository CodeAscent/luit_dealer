// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
   num? id;
   num? category;
   num? brand;
   String? name;
   String? email;
   String? username;
   String? mobile;
   String? address;
   String? country;
   String? city;
   String? state;
   String? pin;
   String? logo;
   String? doc1;
   String? doc2;
   String? doc3;
   String? deposit_amount;
   String? status;
   String? reg_status;
   String? created_at;
   String? updated_at;
   String? deleted_at;
  UserModel({
    this.id,
    this.category,
    this.brand,
    this.name,
    this.email,
    this.username,
    this.mobile,
    this.address,
    this.country,
    this.city,
    this.state,
    this.pin,
    this.logo,
    this.doc1,
    this.doc2,
    this.doc3,
    this.deposit_amount,
    this.status,
    this.reg_status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'brand': brand,
      'name': name,
      'email': email,
      'username': username,
      'mobile': mobile,
      'address': address,
      'country': country,
      'city': city,
      'state': state,
      'pin': pin,
      'logo': logo,
      'doc1': doc1,
      'doc2': doc2,
      'doc3': doc3,
      'deposit_amount': deposit_amount,
      'status': status,
      'reg_status': reg_status,
      'created_at': created_at,
      'updated_at': updated_at,
      'deleted_at': deleted_at,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as num : null,
      category: map['category'] != null ? map['category'] as num : null,
      brand: map['brand'] != null ? map['brand'] as num : null,
      name: map['name'] != null ? map['name'] as String : '',
      email: map['email'] != null ? map['email'] as String : '',
      username: map['username'] != null ? map['username'] as String : '',
      mobile: map['mobile'] != null ? map['mobile'] as String : '',
      address: map['address'] != null ? map['address'] as String : '',
      country: map['country'] != null ? map['country'] as String : '',
      city: map['city'] != null ? map['city'] as String : '',
      state: map['state'] != null ? map['state'] as String : '',
      pin: map['pin'] != null ? map['pin'] as String : '',
      logo: map['logo'] != null ? map['logo'] as String : '',
      doc1: map['doc1'] != null ? map['doc1'] as String : '',
      doc2: map['doc2'] != null ? map['doc2'] as String : '',
      doc3: map['doc3'] != null ? map['doc3'] as String : '',
      deposit_amount: map['deposit_amount'] != null ? map['deposit_amount'] as String : '',
      status: map['status'] != null ? map['status'] as String : '',
      reg_status: map['reg_status'] != null ? map['reg_status'] as String : '',
      created_at: map['created_at'] != null ? map['created_at'] as String : '',
      updated_at: map['updated_at'] != null ? map['updated_at'] as String : '',
      deleted_at: map['deleted_at'] != null ? map['deleted_at'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
