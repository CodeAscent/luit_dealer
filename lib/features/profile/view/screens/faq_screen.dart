import 'package:flutter/material.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'FAQs'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFAQSection(
              'Can I cancel my order?',
              'Yes only if the order is not dispatched yet. You can contact our customer service department to get your order canceled.',
            ),
            _buildFAQSection(
              'Will I receive the same product I see in the photo?',
              'Actual product color may vary from the images shown. Every monitor or mobile display has a different capability to display colors, and every individual may see these colors differently. In addition, lighting conditions at the time the photo was taken can also affect an image\'s color.',
            ),
            _buildFAQSection(
              'Is my personal information confidential?',
              'Your personal information is confidential. We do not rent, sell, barter or trade email addresses. When you place an order with us, we collect your name, address, telephone number, credit card information and your email address. We use this information to fulfill your order and to communicate with you about your order. All your information is kept confidential and will not be disclosed to anybody unless ordered by government authorities.',
            ),
            _buildFAQSection(
              'What payment methods can I use to make purchases?',
              'We offer the following payment methods: PayPal, VISA, MasterCard and Voucher code, if applicable.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            answer,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
