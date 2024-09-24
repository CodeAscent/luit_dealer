import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class CustomOrangeButtom extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final bool? loading;

  const CustomOrangeButtom({
    super.key,
    this.onPressed,
    required this.label,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: loading!
            ? CircularProgressIndicator(
                color: AppColors.whiteColor,
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
