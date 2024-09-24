import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

class JoinBrandRepo {
  joinUs({
    required String brand,
    required String firstname,
    required String lastname,
    required String mobile,
    required String address,
  }) async {
    try {
      final res = await HttpWrapper.postRequest('joinUs', {
        "firstname": firstname,
        "lastname": lastname,
        "mobile": mobile,
        "address": address,
        "brand": brand,
      });

      final data = jsonDecode(res.body);
      Logger().w(data);
      if (res.statusCode == 200) {
        return data;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }
}
