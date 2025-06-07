const String launchesQuery = '''
  query GetPastLaunches(\$limit: Int!, \$offset: Int!) {
  launchesPast(limit: \$limit, offset: \$offset) {
      id
      mission_name
      launch_date_utc
      launch_success
      rocket {
      rocket_name
     }
    links {
      mission_patch
      mission_patch_small
      video_link
    }
      launch_site {
        site_name_long
      }
    }
  }
''';

// const String launchesQuery = '''
//   query GetLaunches(\$limit: Int!, \$offset: Int!) {
//     launchesPast(limit: \$limit, offset: \$offset) {
//       mission_name
//       launch_date_utc
//       launch_success
//       rocket {
//         rocket_name
//       }
//       links {
//         mission_patch_small
//       }
//     }
//   }
// ''';



