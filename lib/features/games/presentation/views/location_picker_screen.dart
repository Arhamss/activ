import 'package:activ/core/models/location_model.dart';
import 'package:activ/core/permissions/permission_manager.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/games/presentation/cubit/cubit.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:activ/utils/widgets/core_widgets/dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  MapboxMap? mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;

  static CameraOptions? _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    // _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: activAppBar(
        context: context,
        title: 'Pick Location',
        onLeadingPressed: () => context.pop(),
        leadingIcon: const Icon(Icons.arrow_back),
      ),
      body: Stack(
        children: [
          // Map Widget
          MapWidget(
            mapOptions: MapOptions(
              pixelRatio: MediaQuery.of(context).devicePixelRatio,
            ),
            cameraOptions: _initialCameraPosition,
            onMapCreated: (MapboxMap mapboxMap) async {
              this.mapboxMap = mapboxMap;
              _pointAnnotationManager =
                  await mapboxMap.annotations.createPointAnnotationManager();
              // await _getCurrentLocation();
            },
            onMapLoadedListener: (mapLoadedEventData) async {
              await _getCurrentLocation();
            },
            onTapListener: (MapContentGestureContext context) async {
              await _onMapTap(context.point);
            },
          ),

          // Current Location Button
          Positioned(
            bottom: 250,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: AppColors.white,
              onPressed: _getCurrentLocation,
              child: const Icon(
                Icons.my_location,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          // Address Display Card
          if (context.watch<GamesCubit>().state.selectedLocation != null)
            Positioned(
              bottom: 140,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selected Location',
                      style: context.b2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context
                          .watch<GamesCubit>()
                          .state
                          .selectedLocation!
                          .address,
                      style: context.b2.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    if (context
                            .watch<GamesCubit>()
                            .state
                            .selectedLocation!
                            .city !=
                        null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${context.watch<GamesCubit>().state.selectedLocation!.city}, ${context.watch<GamesCubit>().state.selectedLocation!.country}',
                        style: context.b3.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

          // Confirm Button
          if (context.watch<GamesCubit>().state.selectedLocation != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ActivButton(
                text: 'Confirm Location',
                isLoading: false,
                onPressed: () {
                  context.pop();
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onMapTap(Point point) async {
    if (mapboxMap == null) return;

    try {
      final latitude = point.coordinates.lat.toDouble();
      final longitude = point.coordinates.lng.toDouble();

      // Add marker at the tapped location
      await _addMarker(latitude, longitude);

      // Get address for the coordinates
      await _getAddressFromCoordinates(latitude, longitude);
    } catch (e) {
      AppLogger.error('Error handling map tap:', e);
    }
  }

  Future<void> _addMarker(double latitude, double longitude) async {
    if (_pointAnnotationManager == null) return;

    try {
      // Clear existing annotations
      await _pointAnnotationManager!.deleteAll();

      // Create new marker
      final pointAnnotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: Position(longitude, latitude)),
        iconSize: 1.5,
        iconImage: 'pin', // Default Mapbox pin icon
      );

      await _pointAnnotationManager!.create(pointAnnotationOptions);
    } catch (e) {
      AppLogger.error('Error adding marker:', e);
    }
  }

  Future<void> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        // Build formatted address
        final addressComponents = <String>[];

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

        final address = addressComponents.isNotEmpty
            ? addressComponents.join(', ')
            : 'Selected Location';

        context.read<GamesCubit>().setSelectedLocation(
              LocationModel(
                latitude: latitude,
                longitude: longitude,
                address: address,
                city: placemark.locality,
                country: placemark.country,
                postalCode: placemark.postalCode,
                placeName: placemark.name,
              ),
            );
      }
    } catch (e) {
      AppLogger.error('Error getting address:', e);
      context.read<GamesCubit>().clearSelectedLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    await PermissionManager.requestLocationPermission(
      grantedCallback: () async {
        try {
          final position = await geo.Geolocator.getCurrentPosition();

          _initialCameraPosition = CameraOptions(
            center: Point(
              coordinates: Position(position.longitude, position.latitude),
            ),
            zoom: 15,
          );

          if (mapboxMap != null) {
            // Move camera to current location
            await mapboxMap!.flyTo(
              CameraOptions(
                center: Point(
                  coordinates: Position(position.longitude, position.latitude),
                ),
                zoom: 15,
              ),
              MapAnimationOptions(duration: 2000),
            );

            await _addMarker(position.latitude, position.longitude);

            await _getAddressFromCoordinates(
              position.latitude,
              position.longitude,
            );
          }
        } catch (e) {
          AppLogger.error('Error getting current location:', e);
        }
      },
      deniedCallback: (message) {
        AppLogger.info('Location permission denied: $message');
        CustomDialog.showOpenSettingsDialog(
          context: context,
          title: 'Location permission required',
        );
      },
    );
  }
}
