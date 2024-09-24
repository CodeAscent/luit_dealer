import 'package:flutter/material.dart';
import 'package:luit_dealer/core/constants/custom_inside_app_bar.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kCustomInsideAppbar(label: 'Help and Support'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image
            Image.asset(
              'assets/Images/LUIT_page42_image2.jpg', // Replace with the actual URL of your image
              height: 200,
            ),
            SizedBox(height: 30),
            Divider(color: AppColors.primaryColor),
            SizedBox(height: 30),
            GestureDetector(
              child: SupportCard(
                onTap: () {
                  _launchPhone('8761828990');
                },
                email: '8761828990',
                description: 'Contact us for any support',
                icon: 'assets/icons/Man On Phone-2.png',
              ),
            ),
            SizedBox(height: 16),

            // Email Support Card 1
            GestureDetector(
              child: SupportCard(
                onTap: () {
                  _launchEmail('luitfanclub@gmail.com');
                },
                email: 'luitfanclub@gmail.com',
                description: 'Email us for any support',
                icon: 'assets/icons/Circled Envelope-1.png',
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              child: SupportCard(
                onTap: () {
                  _launchEmail('pranabbarman463@gmail.com');
                },
                email: 'pranabbarman463@gmail.com',
                description: 'Email us for any support',
                icon: 'assets/icons/Circled Envelope-1.png',
              ),
            ),
            SizedBox(height: 16),
            // Email Support Card 2
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    print('object');
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello&body=How are you?',
    );

    await launchUrl(emailUri);
  }

  Future<void> _launchPhone(String mobile) async {
    print('object');
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: mobile,
    );

    await launchUrl(phoneUri);
  }
}

class SupportCard extends StatelessWidget {
  final String email;
  final String description;
  final String icon;
  final Function()? onTap;
  const SupportCard({
    Key? key,
    required this.email,
    required this.description,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: ListTile(
        leading: Image.asset(icon),
        title: Text(email, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Image.asset('assets/icons/Group 26086156.png'),
        onTap: onTap,
      ),
    );
  }
}
