import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/features/auth/repo/auth_local_repo.dart';
import 'package:luit_dealer/features/auth/view/screens/login_screen.dart';

Future<dynamic> kConfirmLogout() {
  return Get.defaultDialog(
      title: 'Confirm Logout',
      content: Text('Are you sure you want to Log Out?'),
      cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('NO')),
      confirm: TextButton(
          onPressed: () {
            Get.back();
            AuthLocalRepo().removeUserLoginData();
            Get.offAll(() => LoginScreen());
          },
          child: Text('YES')));
}
