import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/confirm_exit.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/dashoard/views/screens/dashboard.dart';
import 'package:luit_dealer/features/lead/view/screens/lead_screen.dart';
import 'package:luit_dealer/features/profile/view/screens/profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          kConfirmExit();
        }
      },
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            pageController.jumpToPage(value);
          },
          currentIndex: currentIndex,
          items: bottomNavItems,
        ),
      ),
    );
  }

  List<Widget> get pages {
    return [
      LeadScreen(),
      DashboardScreen(),
      ProfileScreen(),
    ];
  }

  List<BottomNavigationBarItem> get bottomNavItems {
    return [
      BottomNavigationBarItem(
          label: 'Lead',
          icon: Icon(
            CupertinoIcons.home,
          )),
      BottomNavigationBarItem(
          label: 'Dashboard',
          icon: Icon(
            Icons.dashboard_customize,
          )),
      BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            CupertinoIcons.person,
          )),
    ];
  }
}
