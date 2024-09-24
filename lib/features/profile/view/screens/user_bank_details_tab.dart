import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';

class UserBankDetails extends StatelessWidget {
  const UserBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Get.find<UserViewModel>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Bank Details',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
        //   _buildDetailRow(
        //       'Bank Name', userViewModel.user!.bank_name.toString()),
        //   _buildDetailRow(
        //       'Branch Name', userViewModel.user!.bank_name.toString()),
        //   _buildDetailRow('IFSC Code ', userViewModel.user!.ifsc.toString()),
        //   _buildDetailRow(
        //       'Account Number ', userViewModel.user!.ac_number.toString()),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
            value,
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
