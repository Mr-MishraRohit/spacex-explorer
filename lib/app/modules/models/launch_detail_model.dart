class LaunchDetailModel {
  final String missionName;
  final String siteName;
  final String rocketName;
  final bool? success;
  final String launchDateUtc;
  final String? missionPatch;
  final double? latitude;
  final double? longitude;

  LaunchDetailModel({
    required this.missionName,
    required this.siteName,
    required this.rocketName,
    required this.success,
    required this.launchDateUtc,
    required this.missionPatch,
    required this.latitude,
    required this.longitude,
  });

  factory LaunchDetailModel.fromJson(Map<String, dynamic> json) {
    return LaunchDetailModel(
      missionName: json['mission_name'] ?? '',
      siteName: json['launch_site']?['site_name_long'] ?? '',
      rocketName: json['rocket']?['rocket_name'] ?? '',
      success: json['launch_success'],
      launchDateUtc: json['launch_date_utc'] ?? '',
      missionPatch: json['links']?['mission_patch'],
      latitude: (json['launchpad']?['location']?['latitude'])?.toDouble(),
      longitude: (json['launchpad']?['location']?['longitude'])?.toDouble(),
    );
  }
}
