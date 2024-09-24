import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Privacy Policy'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'At LUIT Fan Club, we are committed to safeguarding the privacy and security of our users\' personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard the information obtained through our e-commerce app. By using LUIT Fan Club, you consent to the practices described in this policy.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildPolicySection(
              '1. Information Collection:',
              '• Personal Information: We may collect personal information such as name, address, email, and phone number when you create an account, make a purchase, or interact with our services.\n'
                  '• Transaction Details: We collect information related to your purchases, including order history, payment method, and shipping details.\n'
                  '• Usage Data: We may collect data on how you interact with our app, such as browsing activity, search queries, and preferences.',
            ),
            _buildPolicySection(
              '2. Information Use:',
              '• Provide Services: We use the collected information to process orders, deliver products, and provide customer support.\n'
                  '• Personalization: We may use your information to personalize your shopping experience, recommend products, and display targeted advertisements.\n'
                  '• Communication: We may use your contact information to send important updates, promotional offers, and newsletters. You can opt-out of these communications at any time.',
            ),
            _buildPolicySection(
              '3. Information Sharing:',
              '• Third-Party Service Providers: We may share your information with trusted third-party service providers who assist us in operating our app, fulfilling orders, and improving our services.\n'
                  '• Legal Compliance: We may disclose personal information if required by law or in response to a valid legal request from authorities.',
            ),
            _buildPolicySection(
              '4. Data Security:',
              '• We implement appropriate security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.\n'
                  '• However, please note that no data transmission over the internet or electronic storage is 100% secure. We cannot guarantee absolute security of your information.',
            ),
            _buildPolicySection(
              '5. User Rights:',
              '• Access and Update: You have the right to access, correct, or update your personal information stored in our app.\n'
                  '• Data Retention: We retain your personal information as long as necessary to provide our services and comply with legal obligations.',
            ),
            _buildPolicySection(
              '6. Children\'s Privacy:',
              '• LUIT Fan Club is not intended for children under the age of 13. We do not knowingly collect or solicit personal information from children.',
            ),
            _buildPolicySection(
              '7. Updates to the Privacy Policy:',
              '• We reserve the right to update this Privacy Policy from time to time. Any changes will be posted on our app, and the revised policy will be effective upon posting.',
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or concerns about our Privacy Policy, please contact our customer support. By using Bharat Local Store, you acknowledge that you have read and understood this Privacy Policy and agree to its terms and conditions.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
