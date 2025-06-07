const String launchDetailQuery = r'''
  query LaunchDetail($id: ID!) {
    launch(id: $id) {
      mission_name
      launch_site {
        site_name_long
      }
      launch_success
      launch_date_utc
      rocket {
        rocket_name
      }
      links {
        mission_patch
      }
      launchpad {
        location {
          latitude
          longitude
        }
      }
    }
  }
''';
