import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLClient initClient() {
    final HttpLink httpLink = HttpLink(
      'https://spacex-production.up.railway.app/',
    );

    return GraphQLClient(
      link: httpLink,
      // cache: GraphQLCache(store: InMemoryStore()),
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}
