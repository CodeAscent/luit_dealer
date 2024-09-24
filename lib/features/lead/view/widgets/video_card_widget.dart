import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class VideoCardWidget extends StatelessWidget {
  final String title;
  final String description;

  const VideoCardWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/icons/image 15.png',
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight:
                          60.0, // Adjust this value to fit your desired number of lines
                    ),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        description,
                        textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            SizedBox(width: 10),
            Image.asset(
              'assets/Images/LUIT_page1_image11.png',
              width: 60,
            ),
          ],
        ),
        SizedBox(height: 15),
        Divider(
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
