import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

kCustomInsideAppbar({required String label}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: Column(
      children: [
        AppBar(
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/icons/arrow-left.png')),
          title: Text(
            label,
            style: TextStyle(color: AppColors.blackColor, fontSize: 20),
          ),
        ),
        Divider(),
      ],
    ),
  );
}
