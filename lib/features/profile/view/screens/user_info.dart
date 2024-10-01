import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/core/services/http_wrapper.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/custom_image_picker.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/core/widgets/custom_tab_bar.dart';
import 'package:luit_dealer/features/auth/repo/auth_local_repo.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:luit_dealer/features/profile/view/screens/user_bank_details_tab.dart';
import 'package:luit_dealer/features/profile/view/screens/user_details_tab.dart';
import 'package:luit_dealer/features/profile/viewModel/profile_viewmodel.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final userViewModel = Get.find<UserViewModel>();
  final profileViewmodel = Get.find<ProfileViewmodel>();
  bool showCities = false;
  final cityController = TextEditingController();
  final searchCityController = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final bank_name = TextEditingController();
  final ac_holder_name = TextEditingController();
  final ac_number = TextEditingController();
  final ifsc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  XFile? profilePic;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // int city_id = userViewModel.user!.city_id ?? 0;

    return GetBuilder<UserViewModel>(initState: (state) async {
      await userViewModel.fetchUserModel(null);
    }, builder: (controller) {
      return Form(
        key: formKey,
        child: Scaffold(
          appBar: kCustomInsideAppbar(label: 'User Information'),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [],
                ),
                SizedBox(height: 20),
                UserDetails(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> kUpdateUserDialog(BuildContext context, int city_id) {
    firstname.text = userViewModel.user!.name.toString();
    // lastname.text = userViewModel.user!.lastname.toString();
    email.text = userViewModel.user!.email.toString();
    address.text = userViewModel.user!.address.toString();
    cityController.text = userViewModel.user!.city.toString();
    // city_id = userViewModel.user!.city_id!;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User Details'),
          content: Container(
            height: Get.height * 0.5,
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    hint: 'First name',
                    controller: firstname,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    hint: 'last name',
                    controller: lastname,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    hint: 'email',
                    controller: email,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: address,
                    hint: 'address',
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    readOnly: true,
                    controller: cityController,
                    suffix: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            backgroundColor: AppColors.whiteColor,
                            title: 'Select City',
                            content:
                                StatefulBuilder(builder: (context, setState) {
                              return Container(
                                width: Get.width,
                                color: Colors.transparent,
                                height: 500,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                margin: EdgeInsets.only(top: 8),
                                child: Scaffold(
                                  appBar: AppBar(
                                    toolbarHeight: 100,
                                    backgroundColor: AppColors.whiteColor,
                                    title: CustomTextField(
                                      onChanged: (p0) {
                                        setState(() {});
                                      },
                                      controller: searchCityController,
                                      hint: 'Search City',
                                    ),
                                    automaticallyImplyLeading: false,
                                  ),
                                  body: SingleChildScrollView(),
                                ),
                              );
                            }),
                          );
                        },
                        icon: Icon(Icons.arrow_downward)),
                    hint: 'City',
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await profileViewmodel.updateProfile(
                      firstname: firstname.text,
                      lastname: lastname.text,
                      email: email.text,
                      address: address.text,
                      city: city_id);
                  await userViewModel.fetchUserModel(null);
                  Get.back();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> kUpdateBankDialog(
    BuildContext context,
  ) {
    // bank_name.text = userViewModel.user!.bank_name.toString();
    // ac_holder_name.text = userViewModel.user!.ac_holder_name.toString();
    // ac_number.text = userViewModel.user!.ac_number.toString();
    // ifsc.text = userViewModel.user!.ifsc.toString();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Bank Details'),
          content: Container(
            width: Get.width,
            height: Get.height * 0.5,
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Bank name',
                  controller: bank_name,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Ac holder name',
                  controller: ac_holder_name,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Ac number',
                  controller: ac_number,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: ifsc,
                  hint: 'IFSC',
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await profileViewmodel.updateBank(
                      bank_name: bank_name.text,
                      ac_holder_name: ac_holder_name.text,
                      ac_number: ac_number.text,
                      ifsc: ifsc.text);
                  await userViewModel.fetchUserModel(null);

                  Get.back();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Column kCustomTabs(String label, String val, Color color) {
    return Column(
      children: [
        Text(label),
        Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          child: Center(
            child: Text(
              val,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
