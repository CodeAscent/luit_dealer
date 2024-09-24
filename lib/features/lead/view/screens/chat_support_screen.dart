import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/lead/view/screens/view_query.dart';
import 'package:luit_dealer/features/lead/view/widgets/chat_card_widget.dart';
import 'package:luit_dealer/features/lead/viewmodel/chat_support.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  final chatSupportViewModel = Get.find<ChatSupportViewModel>();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatSupportViewModel>(initState: (state) {
      chatSupportViewModel.fetchAllQuery();
    }, builder: (controller) {
      return Scaffold(
        appBar: kCustomInsideAppbar(label: 'Chat Support'),
        body: controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(children: [
                    ...List.generate(
                        chatSupportViewModel.queryPage!.data.length,
                        (int index) => ChatCardWidget(
                            onTap: () {
                              Get.to(() => ViewQuery(
                                  q_id: chatSupportViewModel
                                      .queryPage!.data[index].qId
                                      .toString()));
                            },
                            issueNumber: chatSupportViewModel
                                .queryPage!.data[index].qId
                                .toString(),
                            subject: chatSupportViewModel
                                .queryPage!.data[index].subject,
                            createdAt: chatSupportViewModel
                                .queryPage!.data[index].createdAt
                                .toString()))
                  ]),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return Form(
                  key: formKey,
                  child: Material(
                    color: Colors.transparent,
                    child: CupertinoActionSheet(
                      title: Text('Customer Support'),
                      cancelButton: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.cancel_outlined)),
                      actions: [
                        CustomOrangeButtom(
                          label: 'Submit',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Get.back();
                              await controller.newQuery(
                                  message: messageController.text,
                                  subject: subjectController.text);
                              await controller.fetchAllQuery();
                              messageController.clear();
                              subjectController.clear();
                            }
                          },
                        )
                      ],
                      message: Column(
                        children: [
                          Text('Raise a Query'),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (subjectController.text == '') {
                                return 'Write a subject';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(hintText: 'Write a subject...'),
                            controller: subjectController,
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (subjectController.text == '') {
                                return 'Write a message';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(hintText: 'Write a message...'),
                            controller: messageController,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.whiteColor,
            child: Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 35,
            ),
          ),
        ),
      );
    });
  }
}
