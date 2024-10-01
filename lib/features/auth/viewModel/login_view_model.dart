import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/auth/model/user_model.dart';
import 'package:luit_dealer/features/auth/repo/auth_local_repo.dart';
import 'package:luit_dealer/features/auth/repo/login_repo.dart';
import 'package:luit_dealer/features/auth/view/screens/otp_screen.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:luit_dealer/features/bottom_navigation_screen.dart';

class LoginViewModel extends GetxController {
  RxBool loading = false.obs;
  final LoginRepo loginRepo = LoginRepo();
  final UserViewModel userViewModel = Get.put(UserViewModel());
  String? ref_id;
  String fcm_token = '';
//   fetchOtp(String number, bool shouldNavigate) async {
//     loading.value = true;
//     final res = await loginRepo.getOtp(number);
//     if (res != null) {
//       customSnackbar(
//           "4 digit OTP has been sent on your mobile no.", ContentType.success);
//       if (shouldNavigate) {
//         Get.to(() => OtpScreen(
//               number: number,
//             ));
//       }
//     }
//     loading.value = false;
//   }

  updateRefId(String id) {
    ref_id = id;
    update();
  }

  updateFCM(String fcm) {
    fcm_token = fcm;
    update();
  }

//   resendOtp(String number) async {
//     loading.value = true;
//     final res = await loginRepo.getOtp(number);
//     if (res != null) {
//       customSnackbar(
//         "4 digit OTP has been sent on your mobile no.",
//         ContentType.success,
//       );
//     }
//     loading.value = false;
//   }

  login({
    required String number,
    required String password,
  }) async {
    loading.value = true;

    final res = await loginRepo.userLogin(
        number: number, password: password, fcm_token: fcm_token);

    if (res != null) {
      final UserModel user = UserModel.fromMap(res['data']['user']);
      await AuthLocalRepo().saveToken(res['data']['token'], jsonEncode(user));
      await userViewModel.fetchUserModel(user);

      Get.to(() => BottomNavigationScreen());
    }
    loading.value = false;
  }
}
