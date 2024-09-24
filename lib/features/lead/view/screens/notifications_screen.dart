import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/lead/view/widgets/notification_card_widget.dart';
import 'package:luit_dealer/features/lead/viewmodel/notification_viewmodel.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationViewmodel = Get.find<NotificationViewmodel>();
    return GetBuilder<NotificationViewmodel>(initState: (state) {
      notificationViewmodel.fetchAllNotifications();
    }, builder: (controller) {
      return Scaffold(
        appBar: kCustomInsideAppbar(label: 'Notifications'),
        body: notificationViewmodel.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(children: [
                  ...List.generate(
                      controller.notifications.length,
                      (int index) => NotificationCardWidget(
                            subtitle: controller.notifications[index].subtitle,
                            name: controller.notifications[index].name,
                          ))
                ]),
              ),
      );
    });
  }
}
