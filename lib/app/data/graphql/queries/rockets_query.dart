
const String rocketsQuery = '''
  query GetRockets {
    rockets {
      id
      name
      success_rate_pct
      cost_per_launch
      description
      stages
      height {
        meters
      }
      diameter {
        meters
      }
      mass {
        kg
      }
    }
  }
''';

