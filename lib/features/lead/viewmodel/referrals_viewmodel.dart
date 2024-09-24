import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/lead/models/referrals_model.dart';
import 'package:luit_dealer/features/lead/repo/referral_repo.dart';

class ReferralsViewmodel extends GetxController {
  ReferralRepo referralRepo = ReferralRepo();
  RxBool loading = false.obs;
  List<ReferralsModel> referrals = [];
  List<dynamic> referralsById = [];
  fetchReferrals() async {
    loading.value = true;
    final res = await referralRepo.getReferrals();
    if (res != null) {
      referrals = List<ReferralsModel>.from(
          res['data']['data'].map((e) => ReferralsModel.fromJson(e)));
    }
    loading.value = false;
    update();
  }

  fetchReferralsByLeadId(String leadId) async {
    loading.value = true;
    final res = await referralRepo.getReferralsByLeadId(leadId);
    Logger().w(res);

    if (res != null) {
      if (res['data'] != null) {
        referralsById = res['data'];
      } else {
        referralsById = [];
      }
    }
    loading.value = false;
    update();
  }

  updateReferralsByLeadId(String leadId, String remark) async {
    final res = await referralRepo.addRemarkToLead(leadId, remark);
    if (res != null) {
      customSnackbar('Success', ContentType.success);
    }
    update();
  }
}
