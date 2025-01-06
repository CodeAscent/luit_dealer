import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/lead/repo/lead_list_repo.dart';

class LeadListViewmodel extends GetxController {
  final LeadListRepo leadListRepo;

  LeadListViewmodel(this.leadListRepo);

  Future getLeadList() async {
    try {
      final res = await leadListRepo.getLeadList();
      Logger().w(res);
      return res['data']['data'];
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future getLeadById({required String r_id}) async {
    try {
      final res = await leadListRepo.getLeadById(r_id: r_id);
      Logger().w(res);
      return res['data'][0];
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future getRemarks({required String r_id}) async {
    try {
      final res = await leadListRepo.getRemarks(r_id: r_id);
            Logger().w(res);
      return res['data'];
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future addRemark({required String r_id, required String remark, String? nextFollowupDate,String? expectedDeliveryDate}) async {
    try {
      final res = await leadListRepo.addRemark(r_id: r_id, remarks: remark,nextFollowupDate: nextFollowupDate,expectedDeliveryDate: expectedDeliveryDate);
      if (res != null) {
        customSnackbar('Remark added successfully', ContentType.success);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future updateLeadStatus(
      {required String r_id,
      required String remark,
      required int lead_status}) async {
    try {
      final res = await leadListRepo.updateLeadStatus(
          r_id: r_id, remarks: remark, lead_status: lead_status);
      if (res != null) {
        Get.back();
        customSnackbar('Lead status updated', ContentType.success);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
  Future updateLeadPriority(
      {required String r_id,
      required String remark,
      required int lead_priority}) async {
    try {
      final res = await leadListRepo.updateLeadPriority(
          r_id: r_id, remarks: remark, lead_priority: lead_priority);
      if (res != null) {
        Get.back();
        customSnackbar('Lead status updated', ContentType.success);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future assignSale(
      {required int r_id,
      required String remark,
      required int sales_id}) async {
    try {
      final res = await leadListRepo.assignSale(
          r_id: r_id, remarks: remark, sales_id: sales_id);
      if (res != null) {
        customSnackbar('Sale assigned successfully', ContentType.success);
        Get.back();
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future salesmanList() async {
    try {
      final res = await leadListRepo.salesmanList();
      if (res != null) {
        return res['data'];
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future getStatusList() async {
    try {
      final res = await leadListRepo.getStatusList();
      return res['data'];
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
}
