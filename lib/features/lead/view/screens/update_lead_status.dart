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
  Map<int, TextEditingController> remarkControllers = {};
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
      for (var status in statusList) {
        remarkControllers[status['id']] = TextEditingController();
      }
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
          if (selectedStatusId != 0 && remarkControllers[selectedStatusId]?.text.isNotEmpty == true) {
            await leadListViewmodel.updateLeadStatus(
              r_id: widget.data['r_id'].toString(),
              remark: remarkControllers[selectedStatusId]!.text,
              lead_status: selectedStatusId,
            );
            Get.back();
          } else {
            Get.snackbar('Error', 'Please select a status and provide a remark.');
          }
        },
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
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
            Divider(thickness: 1, color: Colors.orange.shade100),
            Expanded(
              child: ListView.builder(
                itemCount: statusList.length,
                itemBuilder: (context, index) {
                  final status = statusList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        activeColor: AppColors.primaryColor,
                        title: Text(
                          status['title'],
                          style: TextStyle(
                            fontWeight: selectedStatusId == status['id']
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        value: selectedStatusId == status['id'],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedStatusId = value == true ? status['id'] : 0;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      if (selectedStatusId == status['id'])
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: CustomTextField(
                            hint: 'Enter a remark...',
                            controller: remarkControllers[status['id']]!,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in remarkControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
