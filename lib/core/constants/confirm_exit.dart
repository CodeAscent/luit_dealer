import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<dynamic> kConfirmExit() {
  return Get.defaultDialog(
      title: 'Confirm Exit',
      content: Text('Are you sure you want to exit?'),
      cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('NO')),
      confirm: TextButton(
          onPressed: () {
            Get.back();
            SystemNavigator.pop();
          },
          child: Text('YES')));
}
