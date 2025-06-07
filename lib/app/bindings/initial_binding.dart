import 'package:get/get.dart';
import '../data/graphql/graphql_client.dart';
import '../modules/launches/controllers/launch_controller.dart';
import '../modules/launches/controllers/rocket_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final client = GraphQLService.initClient();
    Get.put(LaunchController(client));
    Get.put(RocketController(client));
  }
}
