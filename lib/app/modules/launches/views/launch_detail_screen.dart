import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latlong2/latlong.dart';
import 'package:spacex_explorer/app/strings/string_constant.dart';
import 'package:spacex_explorer/app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/ContentText.dart';
import '../../models/launch_model.dart';

class LaunchDetailScreen extends StatelessWidget {
  const LaunchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LaunchModel launch = Get.arguments;
    final LatLng staticLatLng = LatLng(28.5721, -80.6480); // You can change it

    final date = DateTime.tryParse(launch.launchDate ?? '');
    final formattedDate = date != null
        ? DateFormat.yMMMMd().add_jm().format(date.toLocal())
        : StringConstant.unknownDate;

    return Scaffold(
      appBar: AppBar(title: Text(launch.missionName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (launch.missionPatch != null)
              Center(
                child: CachedNetworkImage(
                  imageUrl: launch.missionPatch!,
                  height: 16.h,
                ),
              ),
            SizedBox(height: 3.h),
            ContentText(
              color: Colors.black87,
              text: "${StringConstant.rocket} ${launch.rocketName}",
              textSize: 5.0.w,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 3.h),
            ContentText(
              color: Colors.black87,
              text: "${StringConstant.date} $formattedDate",
              textSize: 5.0.w,
              fontWeight: FontWeight.w600,
            ),
            Text('Site: ${launch.siteName ?? 'Unknown'}'),
            SizedBox(height: 3.h),
            ContentText(
              color: Colors.black87,
              text: "${StringConstant.site} ${launch.siteName ?? 'Unknown'}",
              textSize: 5.0.w,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                ContentText(
                  color: Colors.black87,
                  text: StringConstant.status,
                  textSize: 5.0.w,
                  fontWeight: FontWeight.w600,
                ),

                Icon(
                  launch.launchSuccess == true ? Icons.check_circle : Icons.cancel,
                  color: launch.launchSuccess == true ? Colors.green : Colors.red,
                )
              ],
            ),
            Divider(height: 3.h),
            if (launch.flickrImages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text('Photos:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ContentText(
                    color: Colors.black87,
                    text: StringConstant.photos,
                    textSize: 5.0.w,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 15.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: launch.flickrImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (ctx, i) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: launch.flickrImages[i],
                            width: 20.w,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            SizedBox(height: 3.h),
            if (launch.youtubeLink != null)
              TextButton.icon(
                onPressed: () => launch.youtubeLink!.isNotEmpty
                    ? _launchURL(launch.youtubeLink!)
                    : null,
                icon: const Icon(Icons.play_circle),
                // label: const Text('Watch on YouTube'),
                label: ContentText(
                  color: Colors.purpleAccent.withOpacity(0.8),
                  text: StringConstant.watchOnYouTube,
                  textSize: 4.0.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
            Divider(height: 3.h),
            ContentText(
              color: Colors.black87,
              text: StringConstant.rocketSpecs,
              textSize: 6.2.w,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 2.h),
            ContentText(
              color: Colors.black87,
              text: "${StringConstant.rocketName} ${launch.rocket['rocket_name']}",
              textSize: 4.w,
              fontWeight: FontWeight.w500,
            ),
            ContentText(
              color: Colors.black87,
              text: "${StringConstant.rocketTypes} ${launch.rocket['rocket_type']}",
              textSize: 4.w,
              fontWeight: FontWeight.w500,
            ),

            SizedBox(height: 4.h,),
            SizedBox(
              height: 20.h,
              child: FlutterMap(
                options: MapOptions(
                  center: staticLatLng,
                  zoom: 5.5,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.spacex',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 60,
                        height: 60,
                        point: staticLatLng,
                        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  void _launchURL(String url)async{
    // Can be updated with url_launcher later
    // debugPrint("Open URL: $url");
    if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
    }  }
}
