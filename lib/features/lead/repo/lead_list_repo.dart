import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';

class LeadListRepo {
  Future getLeadList() async {
    try {
      final res = await HttpWrapper.getRequest('${salesOrDealer()}/lead_list');

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

  Future getLeadById({required String r_id}) async {
    try {
      final res = await HttpWrapper.getRequest(
          '${salesOrDealer()}/lead_by_id?r_id=$r_id');

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getRemarks({required String r_id}) async {
    try {
      final res = await HttpWrapper.getRequest(
          '${salesOrDealer()}/lead_remarks?r_id=$r_id');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getStatusList() async {
    try {
      final res =
          await HttpWrapper.getRequest('${salesOrDealer()}/lead_status_list');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addRemark({required String remarks, required String r_id,String? nextFollowupDate,String? expectedDeliveryDate}) async {
    try {
      final res = await HttpWrapper.postRequest(
          '${salesOrDealer()}/add_remarks', {"r_id": r_id, "remarks": remarks,"next_followup_date":nextFollowupDate,"expected_delivery_date":expectedDeliveryDate});
      final data = jsonDecode(res.body);  

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateLeadStatus(
      {required String remarks,
      required String r_id,
      required int lead_status}) async {
    try {
      final res = await HttpWrapper.postRequest(
          '${salesOrDealer()}/update_lead_status',
          {"r_id": r_id, "remarks": remarks, "lead_status": lead_status});
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateLeadPriority(
      {required String remarks,
      required String r_id,
      required int lead_priority}) async {
    try {
      final res = await HttpWrapper.postRequest(
          '${salesOrDealer()}/update_lead_priority',
          {"r_id": r_id, "remarks": remarks, "priority": lead_priority});
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future assignSale(
      {required String remarks,
      required int r_id,
      required int sales_id}) async {
    try {
      final res = await HttpWrapper.postRequest('dealer/assign_sale',
          {"r_id": r_id, "assignRemarks": remarks, "sales_id": sales_id});
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future salesmanList() async {
    try {
      final res = await HttpWrapper.getRequest('dealer/sales_man_list');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      rethrow;
    }
  }
}
