import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';

class LeadListRepo {
  Future getLeadList() async {
    try {
      final res = await HttpWrapper.getRequest('dealer/lead_list');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      rethrow;
    }
  }
}
