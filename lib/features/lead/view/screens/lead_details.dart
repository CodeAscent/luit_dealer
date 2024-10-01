import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/formatter.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/lead/view/screens/update_lead_status.dart';

class LeadDetails extends StatelessWidget {
  final dynamic data;

  const LeadDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Lead Details'),
      //   bottomNavigationBar: CustomOrangeButtom(
      //     label: 'Change Status',
      //     onPressed: () {
      //       Get.to(() => UpdateLeadStatus(
      //             data: data,
      //           ));
      //     },
      //   ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('Profile Details'),
              buildDetailRow('ID', data?['r_id'].toString() ?? ''),
              buildDetailRow('Name', data['user']?['firstname'] ?? ''),
              //   buildDetailRow('First Downline', 'Not Delivered Yet'),
              //   buildDetailRow('Second Downline', 'Not Delivered Yet'),
              //   buildDetailRow('Third Downline', 'Not Delivered Yet'),
              buildDetailRowWithLink(
                  'Remarks', data['remarks'] ?? 'No remarks', ''),
              SizedBox(height: 24),
              buildSectionTitle('Lead Details'),
              buildDetailRow('Model', data['products']?['title'] ?? ''),
              buildDetailRow(
                  'Payment Mode', data['payment_mode']?['payment_title'] ?? ''),
              SizedBox(height: 24),
              buildSectionTitle('Lead Status'),
              buildDetailRow(
                  'Next Follow Up',
                  customDateFormat(
                          date: data['next_followup_date'],
                          format: 'dd MM yyyy') ??
                      ''),
              buildDetailRow(
                  'Assigned At',
                  customDateFormat(
                          date: data['dealer_assign_date'],
                          format: 'dd MM yyyy') ??
                      ''),
              //   buildDetailRow('Status', 'Lost Purchase'),

              buildDetailRow('Priority', data['lead_priority']?['title'] ?? ''),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            detail,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8),
        Divider(
          thickness: 1,
          color: Colors.orange.shade100,
        ),
      ],
    );
  }

  Widget buildDetailRowWithLink(String title, String detail, String linkText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Text(
                detail,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Action for See All
                },
                child: Text(
                  linkText,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
