import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/custom_validations.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_star_text.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';
import 'package:luit_dealer/features/bottom_navigation_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showCities = false;
  List<String> cities = ['Indore', 'Bhopal', 'Delhi'];
  final cityController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode validationType = AutovalidateMode.onUserInteraction;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: validationType,
      key: formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                CustomStarText(
                  label: 'Full Name',
                ),
                CustomTextField(
                  controller: nameController,
                  hint: 'Name surname',
                ),
                SizedBox(height: 30),
                CustomStarText(
                  label: 'Email',
                ),
                CustomTextField(
                  type: TextInputType.emailAddress,
                  controller: emailController,
                  validator: emailValidator,
                  hint: 'Email Address',
                ),
                SizedBox(height: 30),
                CustomStarText(
                  label: 'Address',
                ),
                CustomTextField(
                  controller: addressController,
                  hint: 'Current Address',
                ),
                SizedBox(height: 30),
                CustomTextField(
                  controller: cityController,
                  readOnly: true,
                  hint: 'City',
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          showCities = !showCities;
                        });
                      },
                      icon: Icon(
                        showCities
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 32,
                      )),
                ),
                SizedBox(height: 30),
                Visibility(
                  visible: showCities,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.greyColor,
                        )),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                            cities.length,
                            (int index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cityController.text = cities[index];
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cities[index],
                                          style: TextStyle(
                                              color: AppColors.greyColor,
                                              fontSize: 16),
                                        ),
                                        Visibility(
                                            visible: index != cities.length - 1,
                                            child: Divider()),
                                      ],
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                CustomOrangeButtom(
                  label: 'Proceed',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                    } else {
                      validationType = AutovalidateMode.onUserInteraction;
                    }
                    Get.to(() => BottomNavigationScreen());
                  },
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
