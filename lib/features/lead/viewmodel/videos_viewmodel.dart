import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/features/lead/models/video_model.dart';
import 'package:luit_dealer/features/lead/repo/videos_repo.dart';

class VideosViewmodel extends GetxController {
  RxBool loading = false.obs;
  List<VideoModel> videos = [];
  VideosRepo videosRepo = VideosRepo();
  fetchAllVideos() async {
    loading.value = true;
    final res = await videosRepo.getAllVideos();
    if (res != null) {
      videos = List<VideoModel>.from(
          res['data']['data'].map((e) => VideoModel.fromJson(e)));
    } else {
      videos = [];
    }
    loading.value = false;
    update();
  }
}
