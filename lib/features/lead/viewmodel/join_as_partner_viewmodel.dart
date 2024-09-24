import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/lead/repo/join_brand_repo.dart';

class JoinAsPartnerViewmodel extends GetxController {
  RxBool loading = false.obs;

  JoinBrandRepo joinBrandRepo = JoinBrandRepo();
  joinUs({
    required String brand,
    required String firstname,
    required String lastname,
    required String mobile,
    required String address,
  }) async {
    loading.value = true;

    final res = await joinBrandRepo.joinUs(
        brand: brand,
        firstname: firstname,
        lastname: lastname,
        mobile: mobile,
        address: address);

    if (res != null) {
      Get.back();
      customSnackbar('Success', ContentType.success);
    }
    loading.value = false;
    update();
  }
}
