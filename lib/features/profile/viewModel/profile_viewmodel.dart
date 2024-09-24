import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/profile/repo/profile_repo.dart';

class ProfileViewmodel extends GetxController {
  final profileRepo = ProfileRepo();
  RxBool loading = false.obs;

  updateProfile({
    required String firstname,
    required String lastname,
    required String email,
    required String address,
    required int city,
  }) async {
    try {
      loading.value = true;
      await profileRepo.updateProfile(
          firstname: firstname,
          lastname: lastname,
          email: email,
          address: address,
          city: city);

      update();
      customSnackbar("User Profile Updated Successfully", ContentType.success);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  updateBank({
    required String bank_name,
    required String ac_holder_name,
    required String ac_number,
    required String ifsc,
  }) async {
    try {
      loading.value = true;
      await profileRepo.updateBankDetails(
        bank_name: bank_name,
        ac_number: ac_number,
        ifsc: ifsc,
        ac_holder_name: ac_holder_name,
      );

      update();
      customSnackbar("Bank Details Updated Successfully", ContentType.success);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    } finally {
      loading.value = false;
    }
  }
}
