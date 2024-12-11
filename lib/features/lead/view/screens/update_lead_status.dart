import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';
import 'package:luit_dealer/features/lead/repo/lead_list_repo.dart';
import 'package:luit_dealer/features/lead/viewmodel/lead_list_viewmodel.dart';

class UpdateLeadStatus extends StatefulWidget {
  final dynamic data;
  const UpdateLeadStatus({super.key, required this.data});

  @override
  State<UpdateLeadStatus> createState() => _UpdateLeadStatusState();
}

class _UpdateLeadStatusState extends State<UpdateLeadStatus> {
  List statusList = [];
  int selectedStatusId = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isLoading = true;
  final leadListViewmodel = LeadListViewmodel(LeadListRepo());
  fetchData() async {
    final res = await leadListViewmodel.getStatusList();
    if (res != null) {
      statusList = res;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Status List'),
      bottomNavigationBar: CustomOrangeButtom(
        label: 'Update Status',
        onPressed: () async {
          final _remark = TextEditingController();
          final _formKey = GlobalKey<FormState>();
          if (selectedStatusId != 0) {
            final selectedData =
                statusList.where((e) => e['id'] == selectedStatusId).first;
            String title = selectedData['title'];

            await leadListViewmodel.updateLeadStatus(
                r_id: widget.data['r_id'].toString(),
                remark: title,
                lead_status: selectedStatusId);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       title: Text('Add Remark'),
            //       content: Form(
            //         key: _formKey,
            //         child: CustomTextField(
            //           hint: 'Write a remark...',
            //           controller: _remark,
            //           validator: (p0) {
            //             if (_remark.text == '') {
            //               return 'Write a valid remark...';
            //             }
            //             return null;
            //           },
            //         ),
            //       ),
            //       actions: [
            //         TextButton(
            //             onPressed: () {
            //               Get.back();
            //             },
            //             child: Text('Cancel')),
            //         TextButton(
            //             onPressed: () async {
            //               if (_formKey.currentState!.validate()) {
            //                 await leadListViewmodel.updateLeadStatus(
            //                     r_id: widget.data['r_id'].toString(),
            //                     remark: _remark.text,
            //                     lead_status: selectedStatusId);
            //                 Get.back();
            //               }
            //             },
            //             child: Text('Ok'))
            //       ],
            //     );
            //   },
            // );
          }
        },
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    thickness: 1,
                    color: Colors.orange.shade100,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: statusList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          activeColor: AppColors.primaryColor,
                          title: Text(
                            statusList[index]['title'],
                            style: TextStyle(
                              fontWeight:
                                  selectedStatusId == statusList[index]['id']
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                          value: selectedStatusId == statusList[index]['id'],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedStatusId = statusList[index]['id'];
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
