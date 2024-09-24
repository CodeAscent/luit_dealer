import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/formatter.dart';

class ChatCardWidget extends StatelessWidget {
  final String issueNumber;
  final String subject;
  final String createdAt;
  final Function()? onTap;
  const ChatCardWidget({
    super.key,
    required this.issueNumber,
    required this.subject,
    required this.createdAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Issue Number $issueNumber',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                Image.asset(
                  'assets/Images/LUIT_page1_image13.png',
                  width: 25,
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(subject),
            SizedBox(height: 5),
            Text(
              customDateFormat(date: createdAt, format: 'dd MMM yyyy'),
              style: TextStyle(color: AppColors.greyColor),
            ),
            SizedBox(height: 15),
            Divider(
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
