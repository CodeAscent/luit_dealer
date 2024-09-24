import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

class ReferralRepo {
  getReferrals() async {
    try {
      final res = await HttpWrapper.getRequest(leadList);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  getReferralsByLeadId(String leadId) async {
    try {
      final res =
          await HttpWrapper.getRequest(getRemarksByLeadId + '?lead_id=$leadId');
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  addRemarkToLead(String leadId, String remark) async {
    try {
      final res = await HttpWrapper.postRequest(add_remark_to_lead, {
        "lead_id": leadId,
        "remarks": remark,
      });
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
