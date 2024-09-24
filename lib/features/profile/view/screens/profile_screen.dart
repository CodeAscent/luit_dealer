import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/confirm_logout.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:luit_dealer/features/profile/view/screens/faq_screen.dart';
import 'package:luit_dealer/features/profile/view/screens/help_&_support_screen.dart';
import 'package:luit_dealer/features/profile/view/screens/privacy_policy_screen.dart';
import 'package:luit_dealer/features/profile/view/screens/terms_&_condition_screen.dart';
import 'package:luit_dealer/features/profile/view/screens/user_info.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Get.find<UserViewModel>();
    return GetBuilder<UserViewModel>(initState: (state) {
      userViewModel.fetchUserModel(null);
    }, builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 130,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(160),
                    child: Image.network(
                        "https://dealer.luitfanclub.com/storage/uploads/${controller.user!.username}/" +
                            controller.user!.logo!,
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                              CupertinoIcons.person,
                              size: 40,
                            )),
                  ),
                  // Replace with actual image URL
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.user!.username.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      controller.user!.email.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      kConfirmLogout();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Text('Account Information'),
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                        fontSize: 18),
                  ),
                  _buildListTile(
                    title: 'User Info',
                    icon: Icons.person,
                    onTap: () {
                      Get.to(() => UserInfoScreen());
                      // Handle User Info tap
                    },
                  ),
                  // Divider(),
                  // _buildListTile(
                  //   title: 'Bank Details',
                  //   icon: Icons.account_balance,
                  //   onTap: () {
                  //     // Handle Bank Details tap
                  //   },
                  // ),
                
                  Divider(),
                  ListTile(
                    title: Text('Support & Information'),
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                        fontSize: 18),
                  ),
                  _buildListTile(
                    title: 'Privacy Policy',
                    icon: Icons.privacy_tip,
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen());
                      // Handle Privacy Policy tap
                    },
                  ),
                  Divider(),
                  _buildListTile(
                    title: 'Terms & Conditions',
                    icon: Icons.description,
                    onTap: () {
                      Get.to(() => TermsAndConditionsScreen());

                      // Handle Terms & Conditions tap
                    },
                  ),
                  Divider(),
                  _buildListTile(
                    title: 'FAQs',
                    icon: Icons.help,
                    onTap: () {
                      Get.to(() => FAQScreen());

                      // Handle FAQs tap
                    },
                  ),
                  Divider(),
                  _buildListTile(
                    title: 'Help and Support',
                    icon: Icons.support,
                    onTap: () {
                      Get.to(() => HelpAndSupportScreen());
                      // Handle Help and Support tap
                    },
                  ),
                  Divider(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildListTile(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
