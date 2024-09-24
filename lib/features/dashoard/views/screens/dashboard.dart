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
    );
  }
}
