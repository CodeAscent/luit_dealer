import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackbar(String message, ContentType type) {
//   Get.closeCurrentSnackbar();
  final snackbar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Message',
      message: message,
      contentType: type,
    ),
  );
  ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar);
}
