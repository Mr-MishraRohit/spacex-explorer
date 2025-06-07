import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'launches_screen.dart';
import 'rocket_catalog_screen.dart';

class MainScreen extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  final List<Widget> screens = [
    LaunchesScreen(),
    RocketCatalogScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Launches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Rockets',
          ),
        ],
      ),
    ));
  }
}
