enum Flavor {
  development,
  staging,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Development Flavor';
      case Flavor.staging:
        return 'Staging App';
      case Flavor.production:
        return 'Production App';
      default:
        return 'title';
    }
  }

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.development:
        return 'https://be-dev.prasetiyamulya.ac.id/';
      case Flavor.staging:
        return 'https://be-dev.prasetiyamulya.ac.id/';
      case Flavor.production:
        return 'https://endpoint.prasetiyamulya.ac.id/';
      default:
        return 'link';
    }
  }
}
