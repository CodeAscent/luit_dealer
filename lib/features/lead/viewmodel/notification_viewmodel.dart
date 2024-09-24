import 'package:get/get.dart';
import 'package:luit_dealer/features/lead/models/blog_model.dart';
import 'package:luit_dealer/features/lead/models/notification_model.dart';
import 'package:luit_dealer/features/lead/repo/notifications_repo.dart';

class NotificationViewmodel extends GetxController {
  RxBool loading = false.obs;
  List<NotificationModel> notifications = [];
  NotificationRepo notificationRepo = NotificationRepo();
  fetchAllNotifications() async {
    loading.value = true;
    final res = await notificationRepo.getAllNotifications();
    if (res != null) {
      notifications = List<NotificationModel>.from(
          res['data'].map((e) => NotificationModel.fromMap(e)));
    } else {
      notifications = [];
    }
    loading.value = false;
    update();
  }
}
