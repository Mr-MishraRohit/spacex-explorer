import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:spacex_explorer/app/data/graphql/graphql_client.dart';
import 'package:spacex_explorer/app/modules/launches/controllers/launch_controller.dart';
import 'package:spacex_explorer/app/modules/launches/views/launches_screen.dart';

void main() {
  final client =
  GraphQLService.initClient();
  setUp(() {
    // Inject the controller before running tests
    Get.put(LaunchController(client));
  });

  tearDown(() {
    // Remove the controller after test to avoid conflicts
    Get.delete<LaunchController>();
  });

  testWidgets('LaunchesScreen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: LaunchesScreen(),
      ),
    );


    // Verify loading indicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Allow async load
    await tester.pumpAndSettle();

    // Verify list appears
    expect(find.byType(ListView), findsOneWidget);

    // Expect at least one launch card/tile
    expect(find.byType(Card), findsWidgets);
  });
}
