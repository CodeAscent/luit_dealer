import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';

class ProfileRepo {
  updateProfile({
    required String firstname,
    required String lastname,
    required String email,
    required String address,
    required int city,
  }) async {
    try {
      final res = await HttpWrapper.postRequest('updateProfile', {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "address": address,
        "city": city,
      });
      Logger().w(res.body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  updateBankDetails({
    required String bank_name,
    required String ac_holder_name,
    required String ac_number,
    required String ifsc,
  }) async {
    try {
      final res = await HttpWrapper.postRequest('updateBankDetails', {
        "bank_name": bank_name,
        "ac_holder_name": ac_holder_name,
        "ac_number": ac_number,
        "ifsc": ifsc,
      });
      Logger().w(res.body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
