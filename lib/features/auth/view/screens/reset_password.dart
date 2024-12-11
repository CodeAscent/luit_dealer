import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';
import 'package:luit_dealer/features/auth/view/widgets/otp_pin_box.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';

class ResetPassword extends StatefulWidget {
  final String number;
  const ResetPassword({super.key, required this.number});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isSalesLogin = false;
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final confrimPasswordController = TextEditingController();
  final loginViewModel = Get.find<LoginViewModel>();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode validationType = AutovalidateMode.disabled;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: validationType,
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset Password ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Enter the 4-digit verification code sent to your mobile number.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 40),
              CustomOtpBox(
                controller: otpController,
                number: widget.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        loginViewModel.resetPasswordOtpRequest(
                            number: widget.number,
                            salesOrDealer: isSalesLogin ? 'sales' : 'dealer');
                      },
                      child: Text('Resend OTP?')),
                ],
              ),
              SizedBox(height: 20),
              CustomTextField(
                suffix: IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    icon: Icon(showPassword
                        ? Icons.visibility
                        : Icons.visibility_off)),
                isPassword: !showPassword,
                controller: passwordController,
                validator: (val) {
                  if (val == '') {
                    return 'Enter a valid password';
                  }
                  return null;
                },
                hint: 'Enter password',
                maxLength: 10,
                // type: TextInputType.phone,
              ),
              SizedBox(height: 10),
              CustomTextField(
                suffix: IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    icon: Icon(showPassword
                        ? Icons.visibility
                        : Icons.visibility_off)),
                isPassword: !showPassword,
                controller: confrimPasswordController,
                validator: (val) {
                  if (val == '') {
                    return 'Enter a valid password';
                  }
                  return null;
                },
                hint: 'Confirm password',
                maxLength: 10,
                // type: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Obx(
                () => CustomOrangeButtom(
                  loading: loginViewModel.loading.value,
                  label: 'Submit',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      loginViewModel.resetPassword(
                          number: widget.number,
                          salesOrDealer: isSalesLogin ? 'sales' : 'dealer',
                          password: passwordController.text,
                          otp: otpController.text,
                          password_confirmation:
                              confrimPasswordController.text);
                    } else {
                      validationType = AutovalidateMode.onUserInteraction;
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
