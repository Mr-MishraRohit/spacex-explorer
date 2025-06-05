import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/launch_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LaunchesScreen extends StatelessWidget {
  const LaunchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final launchController = Get.find<LaunchController>();

    return Scaffold(
      appBar: AppBar(title: const Text('SpaceX Past Launches')),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            await launchController.fetchLaunches(refresh: true);
          },
          child: ListView.builder(
            controller: launchController.scrollController,
            itemCount: launchController.launches.length + 1,
            itemBuilder: (context, index) {
              if (index < launchController.launches.length) {
                final launch = launchController.launches[index];
                final date = DateTime.tryParse(launch['launch_date_utc'] ?? '');
                final formattedDate = date != null
                    ? DateFormat.yMMMd().add_jm().format(date.toLocal())
                    : 'Unknown date';

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: launch['links']['mission_patch_small'] != null
                        ? CachedNetworkImage(
                            imageUrl: launch['links']['mission_patch_small'],
                            width: 50,
                            placeholder: (ctx, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (ctx, url, error) =>
                                const Icon(Icons.rocket),
                          )
                        : const Icon(Icons.rocket),
                    title: Text(launch['mission_name'] ?? 'Unnamed Mission'),
                    subtitle: Text(
                      '${launch['rocket']['rocket_name']} • $formattedDate',
                    ),
                    trailing: Icon(
                      launch['launch_success'] == true
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: launch['launch_success'] == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              } else {
                return launchController.hasMore.value
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }
            },
          ),
        );
      }),
    );
  }
}
