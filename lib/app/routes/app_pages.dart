import 'package:get/get.dart';
import '../modules/launches/views/launches_screen.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => const LaunchesScreen(),
    ),
  ];
}
