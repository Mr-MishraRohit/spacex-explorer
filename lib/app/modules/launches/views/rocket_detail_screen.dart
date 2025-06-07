import 'package:flutter/material.dart';
import 'package:spacex_explorer/app/strings/string_constant.dart';
import 'package:spacex_explorer/app/utils/utils.dart';

import '../../../widgets/ContentText.dart';

class RocketDetailScreen extends StatelessWidget {
  final Map<String, dynamic> rocket;

  const RocketDetailScreen({super.key, required this.rocket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(rocket['name'] ?? 'Rocket Details')),
      appBar: AppBar(
        title: ContentText(
          color: Colors.black87,
          text: rocket['name'] ?? 'Rocket Details',
          textSize: 7.0.w,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (rocket['flickr_images'] != null &&
                rocket['flickr_images'].isNotEmpty)
              Image.network(rocket['flickr_images'][0]),

            const SizedBox(height: 12),
            ContentText(
              color: Colors.black87,
              text: StringConstant.description,
              textSize: 6.0.w,
              fontWeight: FontWeight.w600,
            ),
            ContentText(
              color: Colors.black87,
              text: rocket['description'] ?? '',
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 4.h),
            // Text("Specs", style: Theme.of(context).textTheme.titleLarge),
            ContentText(
              color: Colors.black87,
              text: StringConstant.specs,
              textSize: 6.0.w,
              fontWeight: FontWeight.w600,
            ),
            ContentText(
              color: Colors.black87,
              text: "Success Rate: ${rocket['success_rate_pct']}%",
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
            ContentText(
              color: Colors.black87,
              text: "Cost per Launch: \$${rocket['cost_per_launch']}",
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
            ContentText(
              color: Colors.black87,
              text: "Stages: ${rocket['stages']}",
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
            ContentText(
              color: Colors.black87,
              text: "Height: ${rocket['height']?['meters']} m",
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
            ContentText(
              color: Colors.black87,
              text: "Diameter: ${rocket['diameter']?['meters']} m",
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
            ContentText(
              color: Colors.black87,
              text: "Mass: ${rocket['mass']?['kg']} kg",
              textSize: 4.1.w,
              alignment: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
