import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class CustomStarText extends StatelessWidget {
  final String label;
  const CustomStarText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(text: label, children: [
            TextSpan(text: ' *', style: TextStyle(color: AppColors.errorColor))
          ]),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
