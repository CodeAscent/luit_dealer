import 'package:flutter/material.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class CustomTabBar extends StatefulWidget {
  final TabController tabController;
  final List<Widget> tabs;
  final List<Widget> views;
  const CustomTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      required this.views});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void dispose() {
    super.dispose();
    widget.tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.otherWhiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
              indicatorPadding: EdgeInsets.all(5),
              dividerHeight: 0,
              labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor,
              ),
              controller: widget.tabController,
              tabs: widget.tabs),
        ),
        Expanded(
            child: TabBarView(
          controller: widget.tabController,
          children: widget.views,
        ))
      ],
    );
  }
}
