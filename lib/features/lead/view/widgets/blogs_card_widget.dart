import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

class BlogsCardWidget extends StatelessWidget {
  final String title;
  final String description;
  const BlogsCardWidget({
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
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            Image.asset(
              'assets/Images/LUIT_page1_image13.png',
              width: 25,
            ),
          ],
        ),
        SizedBox(height: 5),
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
        SizedBox(height: 15),
        Divider(
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
