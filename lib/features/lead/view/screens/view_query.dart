import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:luit_dealer/core/constants/custom_app_bar.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/formatter.dart';
import 'package:luit_dealer/features/lead/models/querry_message.dart';
import 'package:luit_dealer/features/lead/viewmodel/chat_support.dart';

class ViewQuery extends StatefulWidget {
  final String q_id;
  const ViewQuery({super.key, required this.q_id});

  @override
  State<ViewQuery> createState() => _ViewQueryState();
}

class _ViewQueryState extends State<ViewQuery> {
  final messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final PagingController<int, QuerryMessage> _pagingController =
      PagingController(firstPageKey: 1);
  final chatSupportViewModel = Get.find<ChatSupportViewModel>();

  @override
  void initState() {
    super.initState();

    // Trigger initial page load
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await chatSupportViewModel.fetchQueryById(
          q_id: widget.q_id, page: pageKey);

      final newItems = chatSupportViewModel.querryMessages;

      // Check if we have loaded all the data
      final isLastPage = newItems.length >= chatSupportViewModel.totalMessages;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Query'),
      body: Column(
        children: [
          Expanded(
            child: PagedListView<int, QuerryMessage>(
              scrollController: scrollController,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<QuerryMessage>(
                itemBuilder: (context, querryMessage, index) => Column(
                  crossAxisAlignment: querryMessage.msg_type != 'OUT'
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: querryMessage.msg_type != 'OUT'
                              ? AppColors.primaryColor
                              : AppColors.greyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        querryMessage.message,
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                    Text(
                      customDateFormat(
                          date: querryMessage.created_at, format: 'hh:mm a'),
                      style: TextStyle(color: AppColors.black54Color),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: 'Write a message...'),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    await chatSupportViewModel.replyToQuery(
                      message: messageController.text,
                      q_id: widget.q_id,
                    );
                    chatSupportViewModel.querryMessages.clear();
                    chatSupportViewModel.update();
                    chatSupportViewModel.querryMessages.add(QuerryMessage('OUT',
                        messageController.text, DateTime.now().toString()));

                    _pagingController.appendLastPage(chatSupportViewModel
                        .querryMessages); // refresh to load new messages

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollController.jumpTo(
                        scrollController.position.maxScrollExtent,
                      );
                    });
                    messageController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
