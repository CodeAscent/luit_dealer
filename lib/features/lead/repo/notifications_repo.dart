import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

class NotificationRepo {
  getAllNotifications() async {
    try {
      final res = await HttpWrapper.getRequest('${salesOrDealer()}/notification');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }
  getNotificationCount() async {
    try {
      final res = await HttpWrapper.getRequest('${salesOrDealer()}/notification_count');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }
  readotifications() async {
    try {
      final res = await HttpWrapper.getRequest('${salesOrDealer()}/notification_read');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }
}
