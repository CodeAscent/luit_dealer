import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';
import 'package:pinput/pinput.dart';

class CustomOtpBox extends StatelessWidget {
  final String number;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? autoCheckOtp;
  const CustomOtpBox({
    super.key,
    required this.controller,
    this.validator,
    required this.number,
    this.autoCheckOtp = true,
  });

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Get.find<LoginViewModel>();
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(206, 209, 212, 1)),
        borderRadius: BorderRadius.circular(15),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(15),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(15),
    );
    return Pinput(
      length: 4,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: validator,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
    //   onCompleted: autoCheckOtp!
    //       ? (pin) {}
    //       : (pin) => loginViewModel.loginWithOtp(
    //             number: number,
    //             otp: controller.text,
    //           ),
    );
  }
}
