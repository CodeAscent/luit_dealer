import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/features/auth/model/user_model.dart';
import 'package:luit_dealer/features/auth/repo/auth_local_repo.dart';

class UserViewModel extends GetxController {
  UserModel? user;
  fetchUserModel(UserModel? userData) async {
    final token = await LocalRepo.fetchLocalData('token');
    if (token != null) {
      if (userData == null) {
        final res = await AuthLocalRepo().fetchLoginData();
        Logger().w(res);
        user = UserModel.fromJson(res);
        Logger().f(user);
      } else {
        user = userData;
      }

      //   await AuthLocalRepo().saveToken(user!.token!);
    } else {
      user = null;
    }

    update();
  }
}
