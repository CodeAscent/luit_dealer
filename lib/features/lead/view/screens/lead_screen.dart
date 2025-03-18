import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:luit_dealer/core/constants/custom_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/formatter.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:luit_dealer/features/lead/repo/lead_list_repo.dart';
import 'package:luit_dealer/features/lead/view/screens/lead_details.dart';
import 'package:luit_dealer/features/lead/view/screens/notifications_screen.dart';
import 'package:luit_dealer/features/lead/viewmodel/lead_list_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/notification_viewmodel.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  final userViewModel = Get.find<UserViewModel>();
  final leadListViewmodel = LeadListViewmodel(LeadListRepo());
  List dataa = [];
  int notifCount = 0;
  final notificationViewmodel = Get.find<NotificationViewmodel>();

  fetchData() async {
    dataa = await leadListViewmodel.getLeadList();
    return dataa;
  }

  fetchNotifications() async {
    notifCount = await notificationViewmodel.fetchNotificationsCount();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: customAppBar(label: 'LUIT EARN CLUB', showLeading: false),
          body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Check if dataa is null or empty
                if (dataa == null || dataa.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off, // Icon for no leads
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No leads found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataa.length,
                      itemBuilder: (context, index) {
                        final data = dataa[index];
                        return LeadCard(
                          data: data,
                          onTap: () {
                            Get.to(() => LeadDetailsTabBar(
                                      mobileNo: data['user']['mobile_no'] ?? '',
                                      r_id: data['r_id'],
                                    ))!
                                .then((val) {
                              refresh();
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong'),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox();
            },
          ),
        ),
        Positioned(
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
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningInfo(String title, String amount, String image) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 30,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildGridButton(
      String title, String image, Color color, void Function()? onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                height: 60,
              ),
              SizedBox(height: 16),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeadCard extends StatelessWidget {
  final void Function()? onTap;
  final dynamic data;

  LeadCard({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
              color: data['lead_priority'] == null
                  ? Colors.green
                  : Colors.orange.shade100,
              width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data['user']?['firstname'] ?? '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/Images/LUIT_page1_image13.png',
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          'Model : ${data['products']?['title'] ?? ''}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      // Flexible(
                      //   child: Text(
                      //     'Payment : ${data['payment_mode']?['payment_title'] ?? ''}',
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Assigned At : ${customDateFormat(date: data['dealer_assign_date'], format: 'dd MMM yyyy') ?? ''}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.orange.shade100),
            if (data['lead_priority'] != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    _buildChip(
                      data['lead_status']?['title'] ?? '',
                      Icons.radio_button_checked,
                    ),
                    SizedBox(width: 8),
                    _buildChip(
                      data['payment_mode']?['payment_title'] ?? '',
                      Icons.wallet,
                    ),
                    Spacer(),
                    _buildChip(
                      data['lead_priority']?['title'] ?? '',
                      Icons.calendar_month,
                    ),
                    //   SizedBox(width: 8),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: label == "Hot"
                  ? Colors.red
                  : label == 'Cold'
                      ? Colors.blue
                      : Colors.grey,
              width: 2)),
      child: Row(
        children: [
          Icon(
            icon,
            color: label == "Hot"
                ? Colors.red
                : label == 'Cold'
                    ? Colors.blue
                    : Colors.black,
            size: 20,
          ),
          SizedBox(width: 2),
          Text(label,
              style: TextStyle(
                  color: label == "Hot"
                      ? Colors.red
                      : label == 'Cold'
                          ? Colors.blue
                          : Colors.black,
                  fontSize: 10)),
        ],
      ),
    );
  }
}
