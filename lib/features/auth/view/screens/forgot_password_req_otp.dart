import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';

class ForgotPasswordReqOtp extends StatefulWidget {
  const ForgotPasswordReqOtp({super.key});

  @override
  State<ForgotPasswordReqOtp> createState() => _ForgotPasswordReqOtpState();
}

class _ForgotPasswordReqOtpState extends State<ForgotPasswordReqOtp> {
  bool isSalesLogin = false;
  final phoneController = TextEditingController();
  final loginViewModel = Get.find<LoginViewModel>();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode validationType = AutovalidateMode.disabled;

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
                'Reset Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 150),
              CustomTextField(
                controller: phoneController,
                validator: (val) {
                  if (val!.length < 10) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
                hint: 'Enter phone number',
                maxLength: 10,
                type: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dealer'),
                  SizedBox(width: 5),
                  CupertinoCheckbox(
                      activeColor: AppColors.primaryColor,
                      value: !isSalesLogin,
                      onChanged: (val) {
                        setState(() {
                          isSalesLogin = !isSalesLogin;
                        });
                      }),
                  Text('Sales'),
                  SizedBox(width: 5),
                  CupertinoCheckbox(
                      activeColor: AppColors.primaryColor,
                      value: isSalesLogin,
                      onChanged: (val) {
                        setState(() {
                          isSalesLogin = !isSalesLogin;
                        });
                      }),
                ],
              ),
              Obx(
                () => CustomOrangeButtom(
                  loading: loginViewModel.loading.value,
                  label: 'Continue',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      LocalStorage.sharedPreferences
                          .setBool('isSales', isSalesLogin);
                      loginViewModel.resetPasswordOtpRequest(
                          number: phoneController.text,
                          salesOrDealer: isSalesLogin ? 'sales' : 'dealer');
                    } else {
                      validationType = AutovalidateMode.onUserInteraction;
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
