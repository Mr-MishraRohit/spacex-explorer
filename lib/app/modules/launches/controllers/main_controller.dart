import 'package:get/get.dart';

import '../../../data/graphql/graphql_client.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;
  final client = GraphQLService.initClient();

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
