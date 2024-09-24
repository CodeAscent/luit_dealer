import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/lead/models/downline_tree_model.dart';
import 'package:luit_dealer/features/lead/repo/downline_tree_repo.dart';

class DownlineTreeViewmodel extends GetxController {
  DownlineTreeModel? downlineTree;
  RxBool loading = false.obs;
  DownlineTreeRepo downlineTreeRepo = DownlineTreeRepo();

  fetchUserDownlineTree() async {
    loading.value = true;
    final res = await downlineTreeRepo.getUserDownlineTree();
    loading.value = false;
    update();

    if (res != null) {
      downlineTree = DownlineTreeModel.fromJson(res['data']);
      update();
    } else {
      customSnackbar(ServerException().message, ContentType.failure);
    }
  }
}
