import 'package:get/get.dart';
import 'package:luit_dealer/features/lead/models/blog_model.dart';
import 'package:luit_dealer/features/lead/repo/blogs_repo.dart';

class BlogsViewmodel extends GetxController {
  RxBool loading = false.obs;
  List<BlogModel> blogs = [];
  BlogsRepo blogsRepo = BlogsRepo();
  fetchAllBlogs() async {
    loading.value = true;
    final res = await blogsRepo.getAllBlogs();
    if (res != null) {
      blogs = List<BlogModel>.from(
          res['data']['data'].map((e) => BlogModel.fromJson(e)));
    } else {
      blogs = [];
    }
    loading.value = false;
    update();
  }
}
