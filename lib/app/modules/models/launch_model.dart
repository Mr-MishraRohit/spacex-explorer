class LaunchModel {
  final String id;
  final String missionName;
  final String? missionPatch;
  final String?   youtubeLink;
  final List<String> flickrImages;
  final String? rocketName;
  final bool? launchSuccess;
  final String? launchDate;
  final String? siteName;
  final Map<String, dynamic> rocket;

  LaunchModel({
    required this.id,
    required this.missionName,
    required this.rocketName,
    required this.missionPatch,
    required this.youtubeLink,
    required this.flickrImages,
    required this.launchSuccess,
    required this.launchDate,
    required this.siteName,
    required this.rocket,
  });

  factory LaunchModel.fromMap(Map<String, dynamic> map) {
    return LaunchModel(
      id: map['id'] ?? '0',
      missionName: map['mission_name'] ?? 'Unnamed',
      missionPatch: map['links']['mission_patch'],
      youtubeLink: map['links']['video_link'],
      flickrImages: List<String>.from(map['links']['flickr_images'] ?? []),
      rocketName: map['rocket']['rocket_name'],
      launchSuccess: map['launch_success'],
      launchDate: map['launch_date_utc'],
      siteName: map['launch_site']?['site_name_long'],
      rocket: map['rocket'],
    );
  }
}
