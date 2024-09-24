import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:share_plus/share_plus.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final userViewModel = Get.find<UserViewModel>();

  @protected
//   late QrImage qrImage;

  @override
  void initState() {
    super.initState();
    // final qrCode = QrCode(
    //   8,
    //   QrErrorCorrectLevel.H,
    // )..addData(
    //     'https://app.luitfanclub.com/?ref_id=' + '${userViewModel.user!.id}');

    // qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserViewModel>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'User Details',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildDetailRow('User Name', controller.user!.username!),
            _buildDetailRow('Club Name', 'Bronze Club'),
            // _buildDetailRow('ID', controller.user!.member_id!),
            _buildDetailRow('Contact', controller.user!.mobile!),
            _buildDetailRow('Email', controller.user!.email.toString()),
            _buildDetailRow('City', controller.user!.city),
            // _buildDetailRow('State', 'Maharashtra'),
            SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
