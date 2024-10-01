import 'package:flutter/material.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';

class UpdateLeadStatus extends StatefulWidget {
  final dynamic data;
  const UpdateLeadStatus({super.key, required this.data});

  @override
  State<UpdateLeadStatus> createState() => _UpdateLeadStatusState();
}

class _UpdateLeadStatusState extends State<UpdateLeadStatus> {
  List<String> statusList = [
    'Pending Verification',
    'Pending Callback',
    'Pending Dealership Visit',
    'Pending Test Ride',
  ];
  String selectedStatus = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Status List'),
      bottomNavigationBar: CustomOrangeButtom(
        label: 'Orange',
        onPressed: () {},
      ),
      body: Padding(
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
                      statusList[index],
                      style: TextStyle(
                        fontWeight: selectedStatus == statusList[index]
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    value: selectedStatus == statusList[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedStatus = statusList[index];
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
