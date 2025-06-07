import 'package:get/get.dart';
import 'package:spacex_explorer/app/modules/launches/views/main_screen.dart';
import '../modules/launches/views/launch_detail_screen.dart';
import '../modules/launches/views/launches_screen.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage(name: '/', page: () => MainScreen()),
    GetPage(name: '/launch', page: () => const LaunchesScreen()),

    // inside AppPages.routes:
    GetPage(name: '/details', page: () =>  LaunchDetailScreen()),
  ];
}
