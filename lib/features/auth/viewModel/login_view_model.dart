import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/auth/model/user_model.dart';
import 'package:luit_dealer/features/auth/repo/auth_local_repo.dart';
import 'package:luit_dealer/features/auth/repo/login_repo.dart';
import 'package:luit_dealer/features/auth/view/screens/login_screen.dart';
import 'package:luit_dealer/features/auth/view/screens/otp_screen.dart';
import 'package:luit_dealer/features/auth/view/screens/reset_password.dart';
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
  void subscribeToTopics() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    if (LocalStorage.sharedPreferences.getBool('isSales') ?? false) {
      await messaging.subscribeToTopic('sales');
      Logger().f('Subscribed as sales');
    } else {
      await messaging.subscribeToTopic('dealer');
      Logger().f('Subscribed as dealer');
    }
  }

  login({
    required String number,
    required String password,
    required String salesOrDealer,
  }) async {
    loading.value = true;

    try {
      final res = await loginRepo.userLogin(
          number: number,
          password: password,
          salesOrDealer: salesOrDealer,
          fcm_token: fcm_token);

      if (res != null) {
        await AuthLocalRepo().saveToken(res['data']['token']);
        await userViewModel.fetchUserModel();
        subscribeToTopics();
        Get.to(() => BottomNavigationScreen());
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  resetPasswordOtpRequest({
    required String number,
    required String salesOrDealer,
  }) async {
    // loading.value = true;

    try {
      final res = await loginRepo.resetPasswordOtpRequest(
          number: number, salesOrDealer: salesOrDealer);
      Logger().w(res);
      if (res['success'] == true) {
        Get.to(() => ResetPassword(number: number));
        if (res['message'] != null) {
          customSnackbar(res['message'], ContentType.success);
        }
      } else {
        if (res['message'] != null) {
          customSnackbar(res['message'], ContentType.failure);
        } else {
          customSnackbar('Something went wrong', ContentType.failure);
        }
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  resetPassword({
    required String number,
    required String password,
    required String salesOrDealer,
    required String otp,
    required String password_confirmation,
  }) async {
    loading.value = true;

    try {
      final res = await loginRepo.resetPassword(
          number: number,
          salesOrDealer: salesOrDealer,
          password: password,
          otp: otp,
          password_confirmation: password_confirmation);
      Logger().w(res);
      if (res['success'] == true) {
        Get.offAll(() => LoginScreen());
        if (res['message'] != null) {
          customSnackbar(res['message'], ContentType.success);
        }
      } else {
        if (res['message'] != null) {
          customSnackbar(res['message'], ContentType.failure);
        } else {
          customSnackbar('Something went wrong', ContentType.failure);
        }
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }
}
