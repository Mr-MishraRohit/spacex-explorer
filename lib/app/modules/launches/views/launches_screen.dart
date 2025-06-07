import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spacex_explorer/app/strings/string_constant.dart';
import 'package:spacex_explorer/app/utils/utils.dart';
import 'package:spacex_explorer/app/widgets/ContentText.dart';
import '../../models/launch_model.dart';
import '../controllers/launch_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'launch_counter_down.dart';
import 'launch_filter_bar.dart';

class LaunchesScreen extends StatelessWidget {
  const LaunchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final launchController = Get.find<LaunchController>();
    return Scaffold(
      appBar: AppBar(
        title: ContentText(text: StringConstant.launchScreen, textSize: 5.6.w),
        actions: [
          IconButton(
            icon: const Icon(Icons.reset_tv_outlined),
            onPressed: () {
              launchController.resetFilters();
              launchController.fetchLaunches(refresh: true); // Refresh data
            },
          ),

          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: Obx(() {
              if (launchController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (launchController.launches.isEmpty) {
                return Center(
                  child: ContentText(
                    color: Colors.black87,
                    text: StringConstant.noLaunchesFound,
                    textSize: 3.4.h,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }

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
                      final date = DateTime.tryParse(
                        launch['launch_date_utc'] ?? '',
                      );
                      final formattedDate = date != null
                          ? DateFormat.yMMMd().add_jm().format(date.toLocal())
                          : StringConstant.unknownDate;

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading:
                              launch['links']['mission_patch_small'] != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      launch['links']['mission_patch_small'],
                                  width: 4.w,
                                  placeholder: (ctx, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (ctx, url, error) =>
                                      const Icon(Icons.rocket),
                                )
                              : const Icon(Icons.rocket),
                          title: ContentText(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.black87,
                            text: launch['mission_name'] ?? 'Unnamed Mission',
                            textSize: 5.w,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContentText(
                                color: Colors.black45,
                                text:
                                    '${launch['rocket']['rocket_name']} • $formattedDate',
                                textSize: 4.w,
                              ),
                          LaunchCountdown(launchDate: date!,),
                            ],
                          ),
                          trailing: Icon(
                            launch['launch_success'] == true
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: launch['launch_success'] == true
                                ? Colors.green
                                : Colors.red,
                          ),
                          onTap: () {
                            // navigate to details with LaunchModel
                            final launchModel = LaunchModel.fromMap(launch);
                            Get.toNamed('/details', arguments: launchModel);
                          },
                        ),
                      );
                    } else {
                      return launchController.hasMore.value
                          ? Padding(
                              padding: EdgeInsets.all(14.w),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFilterBottomSheet();
        },
        child: Icon(Icons.filter_list),
      ),
    );
  }

  void showFilterBottomSheet() {
    final controller = Get.find<LaunchController>();

    Get.bottomSheet(
      Container(
        height: 80.h,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: LaunchFilterBar(controller: controller),
      ),
      isScrollControlled: true,
    );
  }
}
