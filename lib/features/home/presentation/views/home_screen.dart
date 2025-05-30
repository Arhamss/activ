import 'package:activ/config/api_environment.dart';
import 'package:activ/core/app_preferences/app_preferences.dart';
import 'package:activ/core/di/injector.dart';
import 'package:activ/core/permissions/permission_manager.dart';
import 'package:activ/exports.dart';
import 'package:activ/features/home/presentation/cubit/cubit.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? mapboxMap;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _searchResults = [];

  static CameraOptions? _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    // Set the access token
    MapboxOptions.setAccessToken(
      ApiEnvironment.current.mapboxAPIKey,
    );

    _getCurrentLocationAndNotificationPermissions();

    // Set initial camera position only if not already set
    // _currentCameraPosition ??= CameraOptions(
    //   center: Point(
    //     coordinates: Position(
    //       55.2708,
    //       25.2048,
    //     ),
    //   ), // Dubai coordinates (lng, lat)
    //   zoom: 13,
    // );
  }

  Future<void> _getCurrentLocationAndNotificationPermissions() async {
    await PermissionManager.requestMultiplePermissions(
      [
        Permission.location,
        Permission.notification,
      ],
    );
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _saveCurrentCameraPosition();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    context.read<HomeCubit>().setIsSearching(true);

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<HomeCubit>().setIsSearching(false);
      if (query.isNotEmpty) {
        // Mock search results - replace with actual search logic
        _searchResults = [
          'Football match at Central Park',
          'Tennis court booking',
          'Swimming pool session',
          'Basketball game tonight',
          'Yoga class downtown',
          'Running group meetup',
        ]
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _searchResults = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          homeState.showSearchBar ? 'Search Activities' : 'Home',
          style: context.b2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          ActivIconButton(
            backgroundColor: AppColors.white,
            icon: const Icon(
              Icons.login_outlined,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Injector.resolve<AppPreferences>().clearAll();
              context.goNamed(AppRouteNames.splash);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MapWidget(
            key: const ValueKey('mapWidget'),
            cameraOptions: _currentCameraPosition,
            onMapCreated: (MapboxMap mapboxMap) {
              this.mapboxMap = mapboxMap;
              _getCurrentLocationPermissions();
            },
            onMapIdleListener: (cameraState) {
              _saveCurrentCameraPosition();
            },
            onTapListener: (cameraState) {
              _saveCurrentCameraPosition();
            },
            onZoomListener: (cameraState) {
              _saveCurrentCameraPosition();
            },
          ),

          // Search bar overlay (only show when search is active)
          if (homeState.showSearchBar) ...[
            // Search Bar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: _performSearch,
                  decoration: InputDecoration(
                    hintText: 'Search for activities, sports, locations...',
                    hintStyle: context.b2.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: AppColors.secondaryColor,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _performSearch('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Search Results Overlay
            if (_searchController.text.isNotEmpty)
              Positioned(
                top: 90,
                left: 20,
                right: 20,
                bottom: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: context.watch<HomeCubit>().state.isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : _searchResults.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: AppColors.secondaryColor
                                        .withOpacity(0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No results found',
                                    style: context.h3.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.sports_soccer,
                                      color: AppColors.primaryColor,
                                    ),
                                    title: Text(
                                      _searchResults[index],
                                      style: context.b1.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Tap to view details',
                                      style: context.b3.copyWith(
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Selected: ${_searchResults[index]}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                ),
              ),
          ],

          // Current location button (only show when not searching)
          if (!homeState.showSearchBar)
            Positioned(
              bottom: 120,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: AppColors.white,
                onPressed: () async {
                  await _getCurrentLocationPermissions();
                },
                child: const Icon(
                  Icons.my_location,
                  color: AppColors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocationPermissions() async {
    await PermissionManager.requestLocationPermission(
      grantedCallback: () async {
        try {
          final position = await geo.Geolocator.getCurrentPosition();

          if (mapboxMap != null) {
            await mapboxMap!.flyTo(
              CameraOptions(
                center: Point(
                  coordinates: Position(position.longitude, position.latitude),
                ),
                zoom: 15,
              ),
              MapAnimationOptions(duration: 2000),
            );

            // Save the new camera position after moving
            await _saveCurrentCameraPosition();
          }
        } catch (e) {
          AppLogger.error('Error getting location:', e);
        }
      },
      deniedCallback: () {
        AppLogger.error('Location permission denied');
        // You could show a snackbar or dialog here
      },
    );
  }

  Future<void> _saveCurrentCameraPosition() async {
    if (mapboxMap != null) {
      try {
        final cameraState = await mapboxMap!.getCameraState();
        _currentCameraPosition = CameraOptions(
          center: cameraState.center,
          zoom: cameraState.zoom,
          bearing: cameraState.bearing,
          pitch: cameraState.pitch,
        );
      } catch (e) {
        print('Error saving camera position: $e');
      }
    }
  }
}
