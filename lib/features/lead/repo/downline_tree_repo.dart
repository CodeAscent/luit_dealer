import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

class DownlineTreeRepo {
  getUserDownlineTree() async {
    try {
      final res = await HttpWrapper.getRequest(user_tree);

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
