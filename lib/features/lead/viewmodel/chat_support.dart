import 'package:get/get.dart';
import 'package:luit_dealer/features/lead/models/querry_message.dart';
import 'package:luit_dealer/features/lead/models/query_model.dart';
import 'package:luit_dealer/features/lead/repo/chat_support_repo.dart';

class ChatSupportViewModel extends GetxController {
  RxBool loading = false.obs;
  QueryPageData? queryPage;
  ChatSupportRepo chatSupportRepo = ChatSupportRepo();
  List<QuerryMessage> querryMessages = [];
  fetchAllQuery() async {
    loading.value = true;
    final res = await chatSupportRepo.getAllQuery();
    if (res != null) {
      queryPage = QueryPageData.fromMap(res['data']);
    } else {
      queryPage = null;
    }
    loading.value = false;
    update();
  }

  newQuery({required String message, required String subject}) async {
    await chatSupportRepo.newQuery(message: message, subject: subject);
  }

  replyToQuery({required String message, required String q_id}) async {
    await chatSupportRepo.replyToQuery(message: message, q_id: q_id);
  }

  int totalMessages = 0; // Store total messages from the response

  fetchQueryById({required String q_id, required int page}) async {
    loading.value = true;
    final res = await chatSupportRepo.getQueryById(q_id: q_id, page: page);

    if (res != null) {
      // Store total messages from the response
      totalMessages = res['data']['total'];

      final newMessages = List<QuerryMessage>.from(
          res['data']['data'].map((e) => QuerryMessage.fromMap(e)));

      // If the first page, reset the messages list
      if (page == 1) {
        querryMessages = newMessages;
      } else {
        querryMessages.addAll(newMessages);
      }
    } else {
      querryMessages = [];
    }
    loading.value = false;
    update();
  }
}
