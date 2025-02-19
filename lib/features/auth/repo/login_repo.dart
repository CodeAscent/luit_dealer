import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

class LoginRepo {
//   Future getOtp(String number) async {
//     try {
//       final res =
//           await HttpWrapper.getRequest(otpToMobileNew + '?mobile=$number');

//       final data = jsonDecode(res.body);
//       if (res.statusCode == 200) {
//         return data;
//       } else {
//         customSnackbar(data['message'], ContentType.failure);
//       }
//     } on ServerException catch (e) {
//       customSnackbar(e.message, ContentType.failure);
//     }
//     return null;
//   }

  Future userLogin({
    required String number,
    required String password,
    required String salesOrDealer,
    required String? fcm_token,
  }) async {
    try {
      Logger().f({
        "mobile_no": number,
        "password": password,
        if (fcm_token != null) "fcm_token": fcm_token,
      });
      final res = await HttpWrapper.postRequest('${salesOrDealer}/login', {
        "mobile_no": number,
        "password": password,
        if (fcm_token != null) "fcm_token": fcm_token,
      });

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future resetPasswordOtpRequest({
    required String number,
    required String salesOrDealer,
  }) async {
    try {
      final res = await HttpWrapper.postRequest(
          '${salesOrDealer}/password_otp_request', {
        "mobile": number,
      });

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future resetPassword({
    required String number,
    required String password,
    required String salesOrDealer,
    required String otp,
    required String password_confirmation,
  }) async {
    try {
      final res =
          await HttpWrapper.postRequest('${salesOrDealer}/password_reset', {
        "mobile": number,
        "password": password,
        "otp": otp,
        "password_confirmation": password_confirmation,
      });

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
