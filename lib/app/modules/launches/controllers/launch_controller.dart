import 'package:flutter/material.dart' show ScrollController;
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/graphql/queries/filtered_launches_query.dart';
import '../../../utils/utils.dart';

class LaunchController extends GetxController {
  final launches = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  final limit = 10;
  final filterLimit = 1000;
  int offset = 0;

  final selectedYear = RxnString();
  final selectedSuccess = RxnBool();
  final selectedRocket = RxnString();

  final scrollController = ScrollController();
  final GraphQLClient client;

  LaunchController(this.client);

  @override
  void onInit() {
    super.onInit();
    fetchLaunches();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading.value &&
        hasMore.value) {
      fetchLaunches();
    }
  }

  // Call this to clear filters
  void resetFilters() {
    selectedYear.value = null;
    selectedRocket.value = null;
    selectedSuccess.value = null;
  }

  Future<void> fetchLaunches({bool refresh = false}) async {
    // If refresh is true, reset offset and clear previous launches
    if (refresh) {
      offset = 0;
      launches.clear();
      hasMore.value = true;
    }

    isLoading.value = true; // Show loading spinner or progress state

    // GraphQL query to fetch past launches with limit and offset for pagination
    // const query = '''
    //   query GetPastLaunches(\$limit: Int!, \$offset: Int!) {
    //     launchesPast(limit: \$limit, offset: \$offset) {
    //       mission_name
    //       launch_date_utc
    //       rocket {
    //         rocket_name
    //       }
    //       launch_success
    //       links {
    //         mission_patch_small
    //       }
    //     }
    //   }
    // ''';

    // Check for internet connectivity using utility method

    bool isConnected = await Utils.isInternetConnected();
    if (isConnected) {
      // When online, fetch data from API with cache fallback

      final result = await client.query(
        QueryOptions(
          document: gql(launchesQuery), // GraphQL query
          fetchPolicy: FetchPolicy.cacheFirst, // ✅ cache for offline
          variables: {'limit': limit, 'offset': offset}, // Required variables
        ),
      );

      if (result.hasException) {
        // Show error if API call fails
        Get.snackbar('Error', result.exception.toString());
        Debug.setLog("Error Set: ${result.exception.toString()}");
        isLoading.value = false;
        hasMore.value = false; // No more data available
      } else {
        // Log the fetched data (optional, for debugging)
        Debug.setLog("Result: ${result.data}");

        // Parse the list of launches from the response
        final fetched = result.data?['launchesPast'] as List?;
        // Add the fetched data to the observable list
        if (fetched != null && fetched.isNotEmpty) {
          Debug.setLog("filtered $fetched");
          launches.addAll(fetched.cast<Map<String, dynamic>>());
          offset += limit; // Move to next page for pagination
        } else {
          hasMore.value = false; // No more data available
          isLoading.value = false;
        }
      }
    } else {
      // No internet available — try to load data from cache
      isLoading.value = false;

      final result = await client.query(
        QueryOptions(
          document: gql(launchesQuery), // GraphQL query
          fetchPolicy: FetchPolicy.cacheFirst, // ✅ cache for offline
          variables: {'limit': limit, 'offset': offset}, // Required variables
        ),
      );

      if (result.hasException) {
        Get.snackbar('Error (Offline)', result.exception.toString());
        isLoading.value = false;
      } else {
        // Log the fetched data (optional, for debugging)
        Debug.setLog("Result (from cache): ${result.data}");
        final fetched = result.data?['launchesPast'] as List?;
        if (fetched != null && fetched.isNotEmpty) {
          launches.addAll(fetched.cast<Map<String, dynamic>>());
          offset += limit;
        } else {
          hasMore.value = false; // No cached data available
        }
      }
      // Notify user they are viewing offline data
      Get.snackbar('No Internet', "Loaded from cache");
    }

    isLoading.value = false;
  }

  Future<void> fetchFilterLaunches({
    String? year,
    String? rocketName,
    String? success,
    bool refresh = false,
  }) async {
    // If refresh is true, reset offset and clear previous launches
    if (refresh) {
      offset = 0;
      launches.clear();
      hasMore.value = true;
    }
    launches.clear();
    isLoading.value = true; // Show loading spinner or progress state

    // Check for internet connectivity using utility method

    bool isConnected = await Utils.isInternetConnected();
    if (isConnected) {
      // When online, fetch data from API with cache fallback

      final result = await client.query(
        QueryOptions(
          // document: gql(query), // GraphQL query
          document: gql(launchesQuery), // GraphQL query
          fetchPolicy: FetchPolicy.cacheFirst, // ✅ cache for offline
          variables: {
            'limit': filterLimit,
            'offset': offset,
          }, // Required variables
        ),
      );

      if (result.hasException) {
        // Show error if API call fails
        Get.snackbar('Error', result.exception.toString());
        Debug.setLog("Error Set: ${result.exception.toString()}");
        isLoading.value = false;
        hasMore.value = false; // No more data available
      } else {
        // Log the fetched data (optional, for debugging)
        Debug.setLog("Result: ${result.data}");

        // Parse the list of launches from the response
        final fetched = result.data?['launchesPast'] as List?;
        // Add the fetched data to the observable list
        if (fetched != null && fetched.isNotEmpty) {
          // 👉 Apply client-side filters here
          final filtered = fetched.where((launch) {
            final launchYear = DateTime.tryParse(
              launch['launch_date_utc'] ?? '',
            )?.year.toString();
            // final matchesYear = year != null && year == launchYear;
            if (year!.isNotEmpty && year == launchYear) {
              return true;
            }

            // if (rocketName != null &&
            //     (launch['rocket']['rocket_name'] as String).toLowerCase().contains(rocketName.toLowerCase())) {
            //   return true;
            // }
            //
            // if (success != null && (launch['launch_success']?.toString() == success)) {
            //
            //   return true;
            // }

            return true; // All active filters matched
          }).toList();

          Debug.setLog("filtered $filtered");
          // launches.addAll(fetched.cast<Map<String, dynamic>>());
          launches.addAll(filtered.cast<Map<String, dynamic>>());
          // offset += limit; // Move to next page for pagination
          hasMore.value = false; // No more data available
        } else {
          hasMore.value = false; // No more data available
          isLoading.value = false;
        }
      }
    } else {
      // No internet available — try to load data from cache
      isLoading.value = false;

      final result = await client.query(
        QueryOptions(
          // document: gql(query), // GraphQL query
          document: gql(launchesQuery), // GraphQL query
          fetchPolicy: FetchPolicy.cacheFirst, // ✅ cache for offline
          variables: {
            'limit': filterLimit,
            'offset': offset,
          }, // Required variables
        ),
      );

      if (result.hasException) {
        Get.snackbar('Error (Offline)', result.exception.toString());
        isLoading.value = false;
      } else {
        // Log the fetched data (optional, for debugging)
        Debug.setLog("Result (from cache): ${result.data}");
        final fetched = result.data?['launchesPast'] as List?;
        if (fetched != null && fetched.isNotEmpty) {
          launches.addAll(fetched.cast<Map<String, dynamic>>());
          offset += limit;
        } else {
          hasMore.value = false; // No cached data available
        }
      }
      // Notify user they are viewing offline data
      Get.snackbar('No Internet', "Loaded from cache");
    }

    isLoading.value = false;
  }
}
