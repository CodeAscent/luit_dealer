import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_app_bar.dart';
import 'package:luit_dealer/features/dashoard/repo/dashboard_repo.dart';
import 'package:luit_dealer/features/dashoard/viewmodel/dashboard_viewmodel.dart';

import '../../../lead/view/screens/notifications_screen.dart';
import '../../../lead/viewmodel/notification_viewmodel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardViewmodel = DashboardViewmodel(DashboardRepo());
  int? selectedWeek;
  int? selectedMonth;  // Month index (0 for January, 1 for February, etc.)
  int? selectedYear;
  String? selectedDate;
  int notifCount = 0;
  final notificationViewmodel = Get.find<NotificationViewmodel>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // setState(() {
      selectedDate = picked.toIso8601String().split('T')[0];
      // });
    }
  }

  Map<String, dynamic> data = {};
  fetchData() async {
    data = await dashboardViewmodel.getDashboard(
      week: selectedWeek,
      month: selectedMonth != null?selectedMonth!+1:null,
      year: selectedYear,
      date: selectedDate,
    );
    return data;
  }

  refresh() async {
    await fetchData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  clearFilter() async {
    selectedWeek = null;
    selectedMonth = null;
    selectedYear = null;
    selectedDate = null;
    refresh();
  }

  fetchNotifications() async {
    notifCount = await notificationViewmodel.fetchNotificationsCount();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // List of month names
    final List<String> monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return Stack(
      children: [
        Scaffold(
            appBar: customAppBar(label: 'LUIT FAN CLUB', showLeading: false),
            body: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Lead Filter'),
                                      content: StatefulBuilder(
                                          builder: (context, setState) {
                                            return Wrap(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: DropdownButton<int>(
                                                          hint: Text('Select Week'),
                                                          value: selectedWeek,
                                                          items: List.generate(52,
                                                                  (index) {
                                                                return DropdownMenuItem(
                                                                  value: index + 1,
                                                                  child: Text(
                                                                      'Week ${index + 1}'),
                                                                );
                                                              }),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedWeek = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                        child: DropdownButton<int>(
                                                          hint: Text('Select Month'),
                                                          value: selectedMonth,
                                                          items: List.generate(
                                                              12, (index) {
                                                            return DropdownMenuItem(
                                                              value: index,
                                                              child: Text(
                                                                  monthNames[index]),
                                                            );
                                                          }),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedMonth = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: TextField(
                                                          decoration:
                                                          InputDecoration(
                                                              hintText:
                                                              'Enter Year'),
                                                          keyboardType:
                                                          TextInputType.number,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedYear =
                                                                  int.tryParse(
                                                                      value);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons.calendar_today),
                                                        onPressed: () =>
                                                            _selectDate(context),
                                                      ),
                                                      SizedBox(width: 8),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            clearFilter();
                                          },
                                          child: Text('Clear Filter'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            refresh();
                                          },
                                          child: Text('Apply Filters'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Filter')),
                        ],
                      ),
                      CustomDashboardCard(
                        label: 'Total Leads',
                        numbers: data['total_leads'].toString(),
                        color: Color(0xffA3BAC4),
                        icon: 'assets/icons/leads.png',
                      ),
                      CustomDashboardCard(
                          icon: 'assets/icons/follow-up.png',
                          label: 'Leads by follow up date',
                          numbers: data['leads_by_followup_date'].toString(),
                          color: Color(0xffFABDD8)),
                      CustomDashboardCard(
                          icon: 'assets/icons/completed.png',
                          label: 'Completed Leads',
                          numbers: data['completed_leads'].toString(),
                          color: Color(0xffE5C4C8)),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: Text('No data found'),
                );
              },
            )),
        Positioned(
          // top: 6,
            right: 20,
            child: SafeArea(
              child: IconButton(
                  onPressed: () {
                    Get.to(() => NotificationsScreen())!.then((val) {
                      fetchNotifications();
                    });
                  },
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 40,
                        color: Colors.white,
                      ),
                      if (notifCount != 0)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10,
                              child: Center(
                                  child: Text(
                                    notifCount.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800),
                                  ))),
                        )
                    ],
                  )),
            ))
      ],
    );
  }
}

class CustomDashboardCard extends StatelessWidget {
  final String label;
  final String numbers;
  final Color color;
  final String icon;
  const CustomDashboardCard({
    super.key,
    required this.label,
    required this.numbers,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      height: 120,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                icon,
                height: 60,
                width: 60,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 7),
                  Text(
                    numbers,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
