import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/utils/location_service.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_state.dart';

class MyAreaSettingsNotifier extends Notifier<MyAreaSettingsState> {
  @override
  MyAreaSettingsState build() {
    Future.microtask(() async {
      _fetchAreaRadiusList();
    });

    // Initial state
    return MyAreaSettingsState(
      // selectedIndex: 0,
      currentRadius: const AreaRadiusModel(zoomLevel: 13, circleRadius: 2000),
      areaRadiusList: [],
      currentLocationCordination: const LocationCordinates(latitude: 41.302542, longitude: 69.238718),
      isLoading: true,
    );
  }

  void updateSliderValue(AreaRadiusModel value) {
    state = state.copyWith(currentRadius: value);
    _updateUserLocationInfo();
  }

  void _fetchAreaRadiusList() async {
    await Future.delayed(const Duration(microseconds: 200));
    try {
      state = state.copyWith(areaRadiusList: [
        AreaRadiusModel.fromMap({'zoom_level': 13.2, 'circle_radius': 2000.0}),
        AreaRadiusModel.fromMap({'zoom_level': 12.6, 'circle_radius': 3000.0}),
        AreaRadiusModel.fromMap({'zoom_level': 12.2, 'circle_radius': 4000.0}),
        AreaRadiusModel.fromMap({'zoom_level': 11.7, 'circle_radius': 6000.0})
      ]);

      await _fetchUserLocationInfo();
    } catch (e, trace) {
      print(e);
      print(trace);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchUserLocationInfo() async {
    try {
      final userRadius = AreaRadiusModel.fromMap({'zoom_level': 13.0, 'circle_radius': 2000.0});
      final userCordinated = LocationCordinates.fromMap({'latitude': 41.302542, 'longitude': 69.238718});

      print('AAAA');
      print(userCordinated);

      await Future.delayed(const Duration(microseconds: 200));
      state = state.copyWith(currentLocationCordination: userCordinated, currentRadius: userRadius);
    } catch (e, trace) {
      print(e);
      print(trace);
    }
  }

  final _locationService = LocationService();

  void updateLocationCordinates() async {
    LocationCordinates location = await _locationService.getCurrentLocation();
    state = state.copyWith(currentLocationCordination: location);
    _updateUserLocationInfo();
  }

  // API TO UPDATE USER LOCATION CORDINATES IN DB
  void _updateUserLocationInfo() async {
    try {
      //api call here
      await Future.delayed(const Duration(microseconds: 200));
    } catch (e, trace) {
      print(e);
      print(trace);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final areaSettingsProvider = NotifierProvider<MyAreaSettingsNotifier, MyAreaSettingsState>(() {
  return MyAreaSettingsNotifier();
});
