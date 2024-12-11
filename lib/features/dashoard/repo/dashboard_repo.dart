import 'dart:convert';

import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';

class DashboardRepo {
  getDashboard({int? week, int? month, int? year, String? date}) async {
    try {
      final queryParameters = {
        if (week != null) 'week': week.toString(),
        if (month != null) 'month': month.toString(),
        if (year != null) 'year': year.toString(),
        if (date != null) 'date': date,
      };
      final res = await HttpWrapper.getRequest('${salesOrDealer()}/dashboard/',
          queryParameters: queryParameters);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        print(data);
        return data;
      }
      throw 'No data found';
    } catch (e) {
      rethrow;
    }
  }
}
