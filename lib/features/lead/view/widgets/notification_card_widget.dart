import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class NotificationCardWidget extends StatelessWidget {
  final String subtitle;
  final String name;
  const NotificationCardWidget({
    super.key,
    required this.subtitle,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          maxLines: 3,
        ),
        SizedBox(height: 15),
        Divider(
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
