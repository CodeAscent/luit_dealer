import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class ReferralsCardWidget extends StatelessWidget {
  final String deliveryStatus;
  final String leadStatus;
  final String followupDate;
  final Color? labelColor;
  final String fullName;
  const ReferralsCardWidget({
    super.key,
    required this.deliveryStatus,
    required this.leadStatus,
    required this.followupDate,
    this.labelColor,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Text(
                  deliveryStatus,
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: labelColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            followupDate,
            style: TextStyle(color: AppColors.greyColor),
          ),
          SizedBox(height: 5),
          Text(fullName),
          SizedBox(height: 5),
          Text(leadStatus),
          SizedBox(height: 15),
          Divider(
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
