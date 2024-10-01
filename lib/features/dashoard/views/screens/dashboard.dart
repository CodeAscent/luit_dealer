import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luit_dealer/core/constants/custom_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(label: 'LUIT FAN CLUB', showLeading: false),
      body: Column(
        children: [
          CustomDashboardCard(
              label: 'Users From Referral',
              numbers: '3504',
              color: Color(0xffA3BAC4)),
          CustomDashboardCard(
              label: 'User From Leads',
              numbers: '3504',
              color: Color(0xffFABDD8)),
          CustomDashboardCard(
              label: 'Today’s Followupl',
              numbers: '3504',
              color: Color(0xffE5C4C8)),
        ],
      ),
    );
  }
}

class CustomDashboardCard extends StatelessWidget {
  final String label;
  final String numbers;
  final Color color;
  const CustomDashboardCard({
    super.key,
    required this.label,
    required this.numbers,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      height: 90,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 7),
            Text(
              numbers,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
