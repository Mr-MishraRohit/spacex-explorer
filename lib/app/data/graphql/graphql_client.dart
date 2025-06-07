import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spacex_explorer/app/appUrl/app_url.dart';

class GraphQLService {
  static GraphQLClient initClient() {
    final HttpLink httpLink = HttpLink(
      AppUrls.baseUrl,
    );

    return GraphQLClient(
      link: httpLink,
      // cache: GraphQLCache(store: InMemoryStore()),
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}
