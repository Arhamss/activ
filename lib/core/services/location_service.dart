import 'package:activ/core/models/location_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Get detailed location information from latitude and longitude
  static Future<LocationModel> getLocationFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        // Build formatted address components
        final addressComponents = <String>[];

        // Add components in order of specificity
        if (placemark.street?.isNotEmpty == true) {
          addressComponents.add(placemark.street!);
        }
        if (placemark.subLocality?.isNotEmpty == true) {
          addressComponents.add(placemark.subLocality!);
        }
        if (placemark.locality?.isNotEmpty == true &&
            !addressComponents.contains(placemark.locality)) {
          addressComponents.add(placemark.locality!);
        }

        // Create formatted address
        final address = addressComponents.isNotEmpty
            ? addressComponents.join(', ')
            : 'Unknown Location';

        // Create location model with all available details
        return LocationModel(
          latitude: latitude,
          longitude: longitude,
          address: address,
          city: placemark.locality,
          state: placemark.administrativeArea,
          country: placemark.country,
          postalCode: placemark.postalCode,
          placeName: placemark.name,
        );
      }

      // Return basic location if no placemark found
      return LocationModel(
        latitude: latitude,
        longitude: longitude,
        address: 'Unknown Location',
      );
    } catch (e) {
      AppLogger.error('Error getting location details:', e);
      // Return basic location on error
      return LocationModel(
        latitude: latitude,
        longitude: longitude,
        address: 'Location Unavailable',
      );
    }
  }

  /// Get current device location with details
  static Future<LocationModel?> getCurrentLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      return getLocationFromCoordinates(
        latitude,
        longitude,
      );
    } catch (e) {
      AppLogger.error('Error getting current location:', e);
      return null;
    }
  }
}
