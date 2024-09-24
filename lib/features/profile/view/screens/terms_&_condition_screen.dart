import 'package:flutter/material.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Terms & Conditions'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Luit Fan Club Terms & Condition:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'We welcome you to LUIT FAN CLUB family. We term you as business Partner rather than just name as Member of it. We share a portion of Profit with all the referral we receive from Luit Fan Club members.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // buildSectionTitle('1. Account Registration:'),
            buildSectionContent(
              'LUIT FAN CLUB is a referral Based Earning Platform. We verify each referral given by our members and then update in the APP for payment after and confirmed and & Genuine Referral Delivery.',
            ),
            SizedBox(height: 16),

            buildSectionContent(
              'Existing Customer of Luit can not be referred in the APP as they are already Luit’s Customer and Luit is already delivering them.',
            ),
            SizedBox(height: 16),

            buildSectionContent(
                'Luit Fan club Management has the final authority to decide if any dispute arises.'),
            SizedBox(height: 16),

            buildSectionContent(
                'Luit Fan Club declare that we are not an MLM organisation and No one will ask money to Enrol 	in Luit Fan Club.'),
            SizedBox(height: 16),

            buildSectionContent(
                'Luit Fan Club will debit TDS or other tax as per Govt. rule and Guidelines to all the members.'),
            SizedBox(height: 16),

            buildSectionContent(
                'Luit Fan Club has the absolute right to change and alter its policy time to time.'),
            SizedBox(height: 16),

            buildSectionContent(
                'Luit Fan Club reserve the right or modification, termination of members etc without prior notice.'),
            SizedBox(height: 16),

            buildSectionContent(
                'Incase of Error, Mistake Luit Fan Club has the right to refuse or cancel.'),

            buildSectionTitle('Account Registration: '),
            buildSectionContent(
                'Luit Fan Club members need to update Bank account details to get their payment in Bank Account whoever Luit Fan Club will pay the payment as per the convenient of management. '),
            SizedBox(height: 16),

            buildSectionContent(
                'Luit Fan Club will add different Brands in the portal/APP and Members can refer and earn from all those brands.'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      '• ' + content,
      style: TextStyle(fontSize: 16),
    );
  }
}
