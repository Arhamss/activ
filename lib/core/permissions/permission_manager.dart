import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static bool _isRequestingPermissions = false;

  // Platform-specific messages
  static String get _locationSettingsMessage => Platform.isIOS
      ? 'Location permission is required. Please enable it in Settings > Privacy & Security > Location Services.'
      : 'Location permission is required. Please enable it in Settings > Apps > Activ > Permissions.';

  static String get _cameraSettingsMessage => Platform.isIOS
      ? 'Camera access is required. Please enable it in Settings > Privacy & Security > Camera.'
      : 'Camera access is required. Please enable it in Settings > Apps > Activ > Permissions.';

  static String get _notificationSettingsMessage => Platform.isIOS
      ? 'Notification access is required. Please enable it in Settings > Notifications.'
      : 'Notification access is required. Please enable it in Settings > Apps > Activ > Notifications.';

  // Platform-specific permission checks
  static Future<bool> _checkLocationServicesEnabled() async {
    try {
      final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled');
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Error checking location services: $e');
      return false;
    }
  }

  static Future<void> requestCameraAndGalleryPermission({
    required void Function() grantedCallback,
    void Function(String message)? deniedCallback,
  }) async {
    if (Platform.isIOS) {
      // iOS: Request camera and photos permissions separately
      final cameraStatus = await Permission.camera.request();
      final photosStatus = await Permission.photos.request();

      if (cameraStatus.isGranted && photosStatus.isGranted) {
        grantedCallback();
      } else {
        deniedCallback?.call(_cameraSettingsMessage);
      }
    } else {
      // Android: Request camera permission only (gallery access is included)
      final cameraStatus = await Permission.camera.request();
      if (cameraStatus.isGranted) {
        grantedCallback();
      } else {
        deniedCallback?.call(_cameraSettingsMessage);
      }
    }
  }

  static Future<void> requestNotificationsPermission({
    void Function()? grantedCallback,
    void Function(String message)? deniedCallback,
  }) async {
    final status = await Permission.notification.request();

    if (status.isGranted) {
      grantedCallback?.call();
    } else {
      deniedCallback?.call(_notificationSettingsMessage);
    }
  }

  static Future<void> requestStoragePermission({
    void Function()? grantedCallback,
    void Function(String message)? deniedCallback,
  }) async {
    if (Platform.isAndroid) {
      // Android 13 (API 33) and above uses photos and videos permissions
      if (await Permission.storage.status.isPermanentlyDenied) {
        deniedCallback?.call(
          'Storage permission is permanently denied. Please enable it in Settings.',
        );
        return;
      }

      final status = await Permission.storage.request();
      if (status.isGranted) {
        grantedCallback?.call();
      } else {
        deniedCallback?.call('Storage access is required for this feature.');
      }
    } else {
      // iOS uses photos permission
      final status = await Permission.photos.request();
      if (status.isGranted) {
        grantedCallback?.call();
      } else {
        deniedCallback
            ?.call('Photo library access is required for this feature.');
      }
    }
  }

  static Future<void> requestLocationPermission({
    required void Function() grantedCallback,
    void Function(String message)? deniedCallback,
  }) async {
    // First check if location services are enabled
    if (!await _checkLocationServicesEnabled()) {
      deniedCallback?.call('Please enable location services on your device.');
      return;
    }

    if (Platform.isIOS) {
      // iOS: Request location permission
      final status = await geo.Geolocator.requestPermission();
      if (status == geo.LocationPermission.whileInUse ||
          status == geo.LocationPermission.always) {
        grantedCallback();
      } else {
        deniedCallback?.call(_locationSettingsMessage);
      }
    } else {
      // Android: Check for fine location permission
      final status = await Permission.locationWhenInUse.request();
      if (status.isGranted) {
        // Check if background location is needed and request it
        final backgroundStatus = await Permission.locationAlways.request();
        if (backgroundStatus.isGranted) {
          grantedCallback();
        } else {
          // Still call granted callback as foreground location is sufficient
          grantedCallback();
        }
      } else if (status.isPermanentlyDenied) {
        deniedCallback?.call(_locationSettingsMessage);
      } else {
        deniedCallback?.call('Location permission was denied.');
      }
    }
  }

  static Future<void> requestMicrophonePermission({
    void Function()? grantedCallback,
    void Function(String message)? deniedCallback,
  }) async {
    final status = await Permission.microphone.request();

    if (status.isGranted) {
      grantedCallback?.call();
    } else if (status.isPermanentlyDenied) {
      final message = Platform.isIOS
          ? 'Microphone access is required. Please enable it in Settings > Privacy & Security > Microphone.'
          : 'Microphone access is required. Please enable it in Settings > Apps > Activ > Permissions.';
      deniedCallback?.call(message);
    } else {
      deniedCallback?.call('Microphone permission was denied.');
    }
  }

  // Request a specific permission
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  // Check if a specific permission is granted
  static Future<bool> isGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  // Check if a specific permission is permanently denied
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }

  // Request multiple permissions at once
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    if (_isRequestingPermissions) {
      debugPrint('Another permission request is already in progress');
      return {};
    }

    try {
      _isRequestingPermissions = true;
      final statusMap = await permissions.request();
      return statusMap;
    } finally {
      _isRequestingPermissions = false;
    }
  }

  // Check multiple permissions
  static Future<bool> arePermissionsGranted(
    List<Permission> permissions,
  ) async {
    for (final permission in permissions) {
      if (!(await isGranted(permission))) {
        return false;
      }
    }
    return true;
  }

  // Open app settings with platform-specific handling
  static Future<bool> openAppSettingsPage() async {
    try {
      final settingsOpened = await openAppSettings();
      return settingsOpened;
    } catch (e) {
      debugPrint('Error opening app settings: $e');
      return false;
    }
  }
}
