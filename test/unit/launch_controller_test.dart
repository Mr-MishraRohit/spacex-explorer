
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:spacex_explorer/app/data/graphql/graphql_client.dart';
import 'package:spacex_explorer/app/modules/launches/controllers/launch_controller.dart';

void main() {
  late LaunchController controller;
  final client = GraphQLService.initClient();

  setUp(() {
    controller = LaunchController(client);
    Get.put(controller);
  });

  tearDown(() {
    Get.delete<LaunchController>();
  });

  test('Initial values are correct', () {
    expect(controller.offset, 0);
    expect(controller.limit, 10);
    expect(controller.launches.isEmpty, true);
  });

  test('Pagination works correctly', () async {
    controller.offset = 0;
    controller.hasMore.value = true;
    // Simulate data fetch
    await controller.fetchLaunches(refresh: true);

    expect(controller.offset > 0, true);
    expect(controller.launches.isNotEmpty, true);
  });

  test('Reset filters works correctly', () {
    controller.selectedYear.value = "2020";
    controller.selectedSuccess.value = true;
    controller.selectedRocket.value = "Falcon";

    controller.resetFilters();

    expect(controller.selectedYear.value, null);
    expect(controller.selectedSuccess.value, null);
    expect(controller.selectedRocket.value, null);
  });
}
