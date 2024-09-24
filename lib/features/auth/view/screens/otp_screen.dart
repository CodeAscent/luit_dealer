import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/screens/sign_up_screen.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';
import 'package:luit_dealer/features/auth/view/widgets/otp_pin_box.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';

class OtpScreen extends StatelessWidget {
  final String number;

  const OtpScreen({
    super.key,
    required this.number,
  });
  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Get.find<LoginViewModel>();
    final otpController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SizedBox(height: 16),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       children: [
                //         Container(
                //             height: 30,
                //             width: 30,
                //             decoration: BoxDecoration(
                //                 color: AppColors.primaryColor,
                //                 borderRadius: BorderRadius.circular(5)),
                //             child: Icon(Icons.check_circle_outline,
                //                 color: AppColors.whiteColor)),
                //         SizedBox(width: 8),
                //         Expanded(
                //           child: Text(
                //             '6-digit Verification code has been sent to your mobile number.',
                //             style: TextStyle(color: AppColors.blackColor),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(height: 40),
                Text(
                  'Mobile Verification',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enter the 4-digit verification code sent to your mobile number.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 40),
                CustomOtpBox(
                  controller: otpController,
                  number: number,
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                    //   loginViewModel.resendOtp(number);
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => CustomOrangeButtom(
                    loading: loginViewModel.loading.value,
                    label: 'Proceed',
                    onPressed: () {
                    //   loginViewModel.loginWithOtp(
                    //     number: number,
                    //     otp: otpController.text,
                    //   );
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
