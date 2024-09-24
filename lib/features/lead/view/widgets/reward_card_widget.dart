import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/formatter.dart';
import 'package:luit_dealer/features/lead/models/reward_model.dart';

class RewardCardWidget extends StatelessWidget {
  final List<RewardModel> rewards;

  const RewardCardWidget({
    super.key,
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        ...List.generate(rewards.length, (int index) {
          final reward = rewards[index];
          return Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/icons/Initiate Money Transfer.png'),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹ ${reward.points}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: AppColors.primaryColor),
                      ),
                      Text(
                        '${customDateFormat(date: reward.received_at!, format: 'dd MMM yy - hh:mm a')}',
                        style: TextStyle(color: AppColors.greyColor),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: AppColors.primaryColor,
              )
            ],
          );
        })
      ],
    );
  }
}
