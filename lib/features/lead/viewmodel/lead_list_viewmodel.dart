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
}
