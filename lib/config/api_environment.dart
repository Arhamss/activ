import 'package:activ/config/flavor_config.dart';

/// API Environments & Configurations
enum ApiEnvironment {
  production,
  staging,
  development,
  qa;

  /// Get API Environment Based on Current Flavor
  static ApiEnvironment get current {
    switch (FlavorConfig.instance.flavor) {
      case Flavor.production:
        return ApiEnvironment.production;
      case Flavor.staging:
        return ApiEnvironment.staging;
      case Flavor.development:
        return ApiEnvironment.development;
      case Flavor.qa:
        return ApiEnvironment.qa;
    }
  }
}
