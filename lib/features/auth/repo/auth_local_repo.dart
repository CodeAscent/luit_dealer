import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/features/auth/model/user_model.dart';
import 'package:luit_dealer/features/auth/repo/login_repo.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';

class AuthLocalRepo {
  final userViewModel = Get.find<UserViewModel>();
  saveToken(String token, String userData) async {
    await LocalRepo.saveLocalData('user', userData);
    // await LocalRepo.saveLocalData('userStats', userStats);
    await LocalRepo.saveLocalData('token', token);
  }

  fetchLoginData() async {
    final res = await LocalRepo.fetchLocalData('user');
    final data = jsonDecode(res);
    return data;
  }

  fetchDealerProfile() async {
    final res = await HttpWrapper.getRequest('dealer/get_profile');
    Logger().f(res.body);
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return data;
    }
    return null;
  }

  removeUserLoginData() async {
    await LocalRepo.removeLocalData('user');
    await LocalRepo.removeLocalData('token');
    // await LocalRepo.removeLocalData('userStats');
  }
}
