import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/features/auth/model/user_model.dart';
import 'package:luit_dealer/features/auth/repo/login_repo.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';

class AuthLocalRepo {
  final userViewModel = Get.find<UserViewModel>();
  saveToken(String token) async {
    // await LocalRepo.saveLocalData('user', userData);
    // await LocalRepo.saveLocalData('userStats', userStats);
    await LocalRepo.saveLocalData('token', token);
  }

  fetchDealerOrSalesProfile() async {
    try {
      final res =
          await HttpWrapper.getRequest('${salesOrDealer()}/get_profile');

      final data = jsonDecode(res.body);
      if (data['success'] == false) {
        AuthLocalRepo().removeUserLoginData();
        throw data['message'];
      } else {
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  removeUserLoginData() async {
    await LocalRepo.removeLocalData('token');
    // await LocalRepo.removeLocalData('userStats');
  }
}
