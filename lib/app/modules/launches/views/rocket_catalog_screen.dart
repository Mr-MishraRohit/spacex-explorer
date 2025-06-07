import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacex_explorer/app/modules/launches/views/rocket_detail_screen.dart';
import 'package:spacex_explorer/app/utils/utils.dart';
import '../../../strings/string_constant.dart';
import '../../../widgets/ContentText.dart';
import '../controllers/rocket_controller.dart';

class RocketCatalogScreen extends StatelessWidget {
  final controller = Get.find<RocketController>(); // Inject controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ContentText(
          color: Colors.black87,
          text: StringConstant.rocketCatalog,
          textSize: 7.0.w,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // Show loading
        }

        if (controller.rockets.isEmpty) {
          return Center(child: ContentText(
            color: Colors.black87,
            text: StringConstant.noRocketsFound,
            textSize: 5.0.w,
            fontWeight: FontWeight.w600,
          ),);
        }

        // Rocket list
        return ListView.builder(
          itemCount: controller.rockets.length,
          itemBuilder: (context, index) {
            final rocket = controller.rockets[index];
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading:
                    rocket['flickr_images'] != null &&
                        rocket['flickr_images'].isNotEmpty
                    ? Image.network(rocket['flickr_images'][0], width: 60)
                    : const Icon(Icons.rocket_launch),
                // title: Text(rocket['name']),
                title: ContentText(
                  color: Colors.black87,
                  text: rocket['name'],
                  textSize: 5.0.w,
                  fontWeight: FontWeight.w600,
                ),
                // subtitle: Text("Success Rate: ${rocket['success_rate_pct']}%"),
                subtitle: ContentText(
                  color: Colors.black87,
                  text: "${StringConstant.successRate} ${rocket['success_rate_pct']}%",
                  textSize: 4.0.w,
                  fontWeight: FontWeight.w400,
                ),
                onTap: () => Get.to(
                  () => RocketDetailScreen(rocket: rocket),
                ), // Go to detail
              ),
            );
          },
        );
      }),
    );
  }
}
