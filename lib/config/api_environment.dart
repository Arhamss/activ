import 'package:activ/config/flavor_config.dart';

/// API Environments & Configurations
enum ApiEnvironment {
  production(
    baseUrl: 'https://activ-backend.onrender.com/',
    apiVersion: 'v1',
    mapboxAPIKey:
        'pk.eyJ1IjoiYWN0aXZzcG9ydHMiLCJhIjoiY21hdXl0Ymk5MDJiMDJscXh4NHIzaXBpNiJ9.Q0Sd2wsSe7ATgAT1_GGTGA',
  ),
  development(
    baseUrl: 'https://activ-backend.onrender.com/',
    apiVersion: 'v1',
    mapboxAPIKey:
        'pk.eyJ1IjoiYWN0aXZzcG9ydHMiLCJhIjoiY21hdXl0Ymk5MDJiMDJscXh4NHIzaXBpNiJ9.Q0Sd2wsSe7ATgAT1_GGTGA',
  );

  const ApiEnvironment({
    required this.baseUrl,
    required this.apiVersion,
    required this.mapboxAPIKey,
  });

  final String baseUrl;
  final String apiVersion;
  final String mapboxAPIKey;

  /// Get API Environment Based on Current Flavor**
  static ApiEnvironment get current {
    switch (FlavorConfig.instance.flavor) {
      case Flavor.production:
        return ApiEnvironment.production;
      case Flavor.development:
        return ApiEnvironment.development;
    }
  }
}
