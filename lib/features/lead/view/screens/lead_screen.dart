import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  final userViewModel = Get.find<UserViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(label: 'LUIT FAN CLUB', showLeading: false),
    );
  }

  Widget _buildEarningInfo(String title, String amount, String image) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 30,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildGridButton(
      String title, String image, Color color, void Function()? onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                height: 60,
              ),
              SizedBox(height: 16),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
