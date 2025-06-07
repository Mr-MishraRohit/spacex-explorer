
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/graphql/queries/rockets_query.dart';
import '../../../utils/utils.dart';

class RocketController extends GetxController {
  final rockets = <Map<String, dynamic>>[].obs; // List of rockets
  final isLoading = false.obs; // Loading indicator
  final GraphQLClient client;

  RocketController(this.client);
  // Fetch rockets from GraphQL API (or cache if offline)
  Future<void> fetchRockets() async {
    isLoading.value = true;

    final QueryOptions options = QueryOptions(
      document: gql(rocketsQuery), // GraphQL query for all rockets
      fetchPolicy: FetchPolicy.cacheFirst, // Use cache if available
    );
    bool isConnected = await Utils.isInternetConnected();
    if (isConnected) {
      final result = await client.query(options);

      if (result.hasException) {
        Get.snackbar('Error', result.exception.toString());
      } else {
        final List<dynamic>? data = result.data?['rockets'];
        if (data != null) {
          rockets.value = data.cast<Map<String, dynamic>>(); // Update UI with rocket list
        }
      }
    }else{
      Get.snackbar('No Internet', "No Internet Connection");
    }


    isLoading.value = false;
  }

  @override
  void onInit() {
    fetchRockets(); // Auto-fetch on screen load
    super.onInit();
  }
}
