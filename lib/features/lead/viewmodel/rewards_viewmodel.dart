import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/features/lead/models/reward_model.dart';
import 'package:luit_dealer/features/lead/repo/reward_repo.dart';

class RewardsViewmodel extends GetxController {
  RewardRepo rewardRepo = RewardRepo();
  RxBool loading = false.obs;
  List<RewardModel> availableRewards = [];
  List<RewardModel> withdrawlRewards = [];

  fetchAvailableRewards() async {
    loading.value = true;
    final res = await rewardRepo.getAvailableRewards();
    Logger().w(res);
    if (res['success'] != false) {
      if (res != null) {
        availableRewards = List<RewardModel>.from(
            res['data'].map((e) => RewardModel.fromJson(e)));
      }
    }

    loading.value = false;
    update();
  }

  fetchWithdrawlRewards() async {
    loading.value = true;
    final res = await rewardRepo.getWithdrawlRewards();
    if (res != null) {
      withdrawlRewards = List<RewardModel>.from(
          res['data'].map((e) => RewardModel.fromJson(e)));
    }
    loading.value = false;
    update();
  }
}
