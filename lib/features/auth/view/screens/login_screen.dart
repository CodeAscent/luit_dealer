import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/screens/otp_screen.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_star_text.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginViewModel = Get.find<LoginViewModel>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode validationType = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Form(
        autovalidateMode: validationType,
        key: formKey,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/Images/LUIT_page2_image1.png',
                    height: 300,
                  ),
                  //   Spacer(),
                  Text(
                    'Login ',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
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

                  CustomTextField(
                    controller: passwordController,
                    validator: (val) {
                      if (val == '') {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                    hint: 'Enter password',
                    maxLength: 10,
                    type: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => CustomOrangeButtom(
                      loading: loginViewModel.loading.value,
                      label: 'Submit',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginViewModel.login(
                              number: phoneController.text,
                              password: passwordController.text);
                        } else {
                          validationType = AutovalidateMode.onUserInteraction;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  Spacer(),
                  Text(
                    'By login, you agree to our Privacy Policy and Terms & Conditions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
