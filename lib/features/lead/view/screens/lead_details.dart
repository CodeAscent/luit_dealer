// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:luit_dealer/core/utils/formatter.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_orange_button.dart';
import 'package:luit_dealer/features/auth/view/widgets/custom_text_field.dart';
import 'package:luit_dealer/features/lead/repo/lead_list_repo.dart';
import 'package:luit_dealer/features/lead/view/screens/update_lead_status.dart';
import 'package:luit_dealer/features/lead/viewmodel/lead_list_viewmodel.dart';

class LeadDetailsTabBar extends StatefulWidget {
  final dynamic r_id;

  const LeadDetailsTabBar({Key? key, required this.r_id}) : super(key: key);

  @override
  State<LeadDetailsTabBar> createState() => _LeadDetailsTabBarState();
}

class _LeadDetailsTabBarState extends State<LeadDetailsTabBar>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> data = Map();
  List remarks = [];
  final leadListViewmodel = LeadListViewmodel(LeadListRepo());
  bool isLoading = true;
  fetchData() async {
    data = await leadListViewmodel.getLeadById(r_id: widget.r_id.toString());
    final res =
        await leadListViewmodel.getRemarks(r_id: widget.r_id.toString());
    if (res != null) {
      remarks = res;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        print(_tabController.index);
        setState(() {});
      });
    fetchData();
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(
        label: 'Lead Details',
      ),
      bottomNavigationBar: Visibility(
        replacement: CustomOrangeButtom(
          label: 'Assign Sales',
          onPressed: () {
            int? selectedSales_id;
            final _remark = TextEditingController();
            bool showNextPage = false;
            final _formKey = GlobalKey<FormState>();

            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text('Assign Sales'),
                    content: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: !showNextPage
                            ? Wrap(
                                children: [
                                  FutureBuilder(
                                    future: leadListViewmodel.salesmanList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              snapshot.data.length,
                                              (int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedSales_id = snapshot
                                                      .data[index]['admin_id'];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: selectedSales_id ==
                                                            snapshot.data[index]
                                                                ['admin_id']
                                                        ? AppColors.primaryColor
                                                        : null,
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                margin: EdgeInsets.all(5),
                                                child: Text(
                                                  '${snapshot.data[index]['firstname']} ${snapshot.data[index]['lastname']}',
                                                  style: TextStyle(
                                                      color: selectedSales_id ==
                                                              snapshot.data[
                                                                      index]
                                                                  ['admin_id']
                                                          ? Colors.white
                                                          : null),
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Center(
                                        child: Text('No data found'),
                                      );
                                    },
                                  )
                                ],
                              )
                            : Wrap(
                                children: [
                                  CustomTextField(
                                    controller: _remark,
                                    hint: 'write a remark',
                                    validator: (p0) {
                                      if (_remark.text == '') {
                                        return 'write a remark';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel')),
                      Visibility(
                        replacement: TextButton(
                            onPressed: () {
                              if (selectedSales_id != null) {
                                setState(() {
                                  showNextPage = true;
                                });
                              }
                            },
                            child: Text('Next')),
                        visible: showNextPage,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                leadListViewmodel.assignSale(
                                    r_id: widget.r_id,
                                    remark: _remark.text,
                                    sales_id: selectedSales_id!);
                              }
                            },
                            child: Text('Ok')),
                      )
                    ],
                  );
                });
              },
            );
          },
        ),
        visible: LocalStorage.sharedPreferences.getBool('isSales') ?? false,
        child: CustomOrangeButtom(
          label: _tabController.index == 0 ? 'Change Status' : 'Add Remark',
          onPressed: () {
            if (_tabController.index == 0) {
              Get.to(() => UpdateLeadStatus(
                        data: data,
                      ))!
                  .then((val) {
                fetchData();
              });
            } else {
              final _remark = TextEditingController();
              final _formKey = GlobalKey<FormState>();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add Remark'),
                    content: Form(
                      key: _formKey,
                      child: CustomTextField(
                        hint: 'Write a remark...',
                        controller: _remark,
                        validator: (p0) {
                          if (_remark.text == '') {
                            return 'Write a valid remark...';
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel')),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await leadListViewmodel.addRemark(
                                  r_id: widget.r_id.toString(),
                                  remark: _remark.text);
                              Get.back();
                              fetchData();
                            }
                          },
                          child: Text('Ok'))
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
      body: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Details'),
            Tab(text: 'Remarks'),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(controller: _tabController, children: [
                LeadDetailsTab(data: data),
                RemarksTab(
                  remarks: remarks,
                )
              ]),
      ),
    );
  }
}

class RemarksTab extends StatelessWidget {
  final List remarks;
  const RemarksTab({
    super.key,
    required this.remarks,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...remarks.map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['remarks'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      customDateFormat(
                          date: e['created_date'],
                          format: 'dd MMM yyyy hh:mm a'),
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class LeadDetailsTab extends StatelessWidget {
  final Map<String, dynamic> data;
  const LeadDetailsTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final leadListViewmodel = Get.put(LeadListViewmodel(LeadListRepo()));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Profile Details'),
            buildDetailRow('ID', data?['r_id'].toString() ?? ''),
            buildDetailRow('Name', data['user']?['firstname'] ?? ''),
            //   buildDetailRow('First Downline', 'Not Delivered Yet'),
            //   buildDetailRow('Second Downline', 'Not Delivered Yet'),
            //   buildDetailRow('Third Downline', 'Not Delivered Yet'),
            buildDetailRowWithLink(
                'Remarks', data['remarks'] ?? 'No remarks', ''),
            SizedBox(height: 24),
            buildSectionTitle('Lead Details'),
            buildDetailRow('Model', data['products']?['title'] ?? ''),
            buildDetailRow(
                'Payment Mode', data['payment_mode']?['payment_title'] ?? ''),
            SizedBox(height: 24),
            buildSectionTitle('Lead Status'),
            buildDetailRow(
                'Next Follow Up',
                customDateFormat(
                        date: data['next_followup_date'],
                        format: 'dd MM yyyy') ??
                    ''),
            buildDetailRow(
                'Assigned At',
                customDateFormat(
                        date: data['dealer_assign_date'],
                        format: 'dd MM yyyy') ??
                    ''),
            //   buildDetailRow('Status', 'Lost Purchase'),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDetailRow(
                    'Priority ', data['lead_priority']?['title'] ?? ''),
                if (LocalStorage.sharedPreferences.getBool('isSales') == true)
                  IconButton(
                      onPressed: () {
                        final _remarks = TextEditingController();
                        final _priority = TextEditingController(text: 'Cold');
                        final _priorityNumber =
                            TextEditingController(text: '1');
                        final _formkey = GlobalKey<FormState>();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Form(
                              key: _formkey,
                              child: AlertDialog(
                                title: Text('Update lead priority'),
                                content: Container(
                                  height: 170,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        controller: _remarks,
                                        hint: 'Remarks',
                                      ),
                                      SizedBox(height: 20),
                                      CustomTextField(
                                        readOnly: true,
                                        controller: _priority,
                                        suffix: DropdownButton(
                                          underline: SizedBox(),
                                          items: [
                                            DropdownMenuItem(
                                              value: 'Cold',
                                              child: Text('Cold'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Hot',
                                              child: Text('Hot'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Warm',
                                              child: Text('Warm'),
                                            )
                                          ],
                                          onChanged: (val) {
                                            switch (val) {
                                              case 'Cold':
                                                _priorityNumber.text = '1';
                                                _priority.text = 'Cold';
                                              case 'Warm':
                                                _priorityNumber.text = '2';
                                                _priority.text = 'Warm';
                                              case 'Hot':
                                                _priorityNumber.text = '3';
                                                _priority.text = 'Hot';
                                                break;
                                              default:
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          Get.back();

                                          await leadListViewmodel
                                              .updateLeadPriority(
                                                  r_id: data['r_id'].toString(),
                                                  remark: _remarks.text,
                                                  lead_priority: int.parse(
                                                      _priorityNumber.text));
                                        }
                                      },
                                      child: Text('Yes'))
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            detail,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
      ],
    );
  }

  Widget buildDetailRowWithLink(String title, String detail, String linkText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Text(
                detail,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Action for See All
                },
                child: Text(
                  linkText,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
