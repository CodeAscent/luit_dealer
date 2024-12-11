import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/features/auth/model/user_model.dart';
import 'package:luit_dealer/features/auth/repo/auth_local_repo.dart';

class UserViewModel extends GetxController {
  UserModel? user;
  fetchUserModel() async {
    final token = await LocalRepo.fetchLocalData('token');
    if (token != null) {
      try {
        final res = await AuthLocalRepo().fetchDealerOrSalesProfile();
        print('----------> $res');
        user = UserModel.fromMap(res['data']);
        Logger().f(user);
      } catch (e) {
        rethrow;
      }
    }

    update();
  }
}
