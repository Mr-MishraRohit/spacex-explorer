import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spacex_explorer/app/strings/string_constant.dart';
import 'app/bindings/initial_binding.dart';
import 'app/data/graphql/graphql_client.dart';
import 'app/modules/launches/controllers/launch_controller.dart';
import 'app/routes/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter(); // Required by graphql_flutter cache


  final client =
  GraphQLService.initClient(); // Initializes the GraphQL client instance
  Get.put(LaunchController(client)); // Register here

  runApp(
    MyApp(client: client,),
  ); // Starts the Flutter app and injects the GraphQL client
}


class MyApp extends StatelessWidget {
  final GraphQLClient? client;


  const MyApp({super.key, this.client});


  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      // Makes the GraphQL client accessible to the widget tree via Provider
      client: ValueNotifier(client!),
      // Root of the app using GetX for routing, binding, and state management
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode:ThemeMode.system,
        title: StringConstant.appName,
      ),
    );
  }
}
