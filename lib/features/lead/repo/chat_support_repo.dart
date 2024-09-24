import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

class ChatSupportRepo {
  getAllQuery() async {
    try {
      final res = await HttpWrapper.getRequest("getAllQuery?per_page=10000000");

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

  newQuery({required String message, required String subject}) async {
    try {
      final res = await HttpWrapper.postRequest(
          "newQuery", {"subject": subject, "message": message});

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

  replyToQuery({required String message, required String q_id}) async {
    try {
      final res = await HttpWrapper.postRequest(
          "replyToQuery", {"query_id": q_id, "message": message});

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

  getQueryById({required String q_id, required int page}) async {
    try {
      final res = await HttpWrapper.getRequest(
          "getQueryById?query_id=$q_id&page=$page");

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
