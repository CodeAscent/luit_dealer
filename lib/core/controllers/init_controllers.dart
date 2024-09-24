import 'package:get/get.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:luit_dealer/features/lead/viewmodel/blogs_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/chat_support.dart';
import 'package:luit_dealer/features/lead/viewmodel/downline_tree_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/join_as_partner_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/notification_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/referrals_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/rewards_viewmodel.dart';
import 'package:luit_dealer/features/lead/viewmodel/videos_viewmodel.dart';
import 'package:luit_dealer/features/profile/viewModel/profile_viewmodel.dart';

initControllers() {
  Get.put(LoginViewModel());
  Get.put(UserViewModel());

  Get.put(DownlineTreeViewmodel());
  Get.put(RewardsViewmodel());
  Get.put(ReferralsViewmodel());
  Get.put(VideosViewmodel());
  Get.put(BlogsViewmodel());
  Get.put(JoinAsPartnerViewmodel());
  Get.put(NotificationViewmodel());
  Get.put(ProfileViewmodel());
  Get.put(ChatSupportViewModel());
}
