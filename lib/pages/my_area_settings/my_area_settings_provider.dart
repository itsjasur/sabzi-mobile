import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_state.dart';

class MyAreaSettingsNotifier extends Notifier<MyAreaSettingsState> {
  @override
  MyAreaSettingsState build() {
    // You can access other providers here
    // final apiClient = ref.watch(apiClientProvider);

    // Initial state
    _fetchAreaRadiusList();
    _fetchMyAreaRadius();
    return MyAreaSettingsState(selectedIndex: 0, areaRadiusList: []);
  }

  void updateSliderValue(int value) {
    if (value >= 0 && value < state.areaRadiusList.length) {
      state = state.copyWith(selectedIndex: value);
    }
  }

  void _fetchAreaRadiusList() async {
    await Future.delayed(const Duration(seconds: 1));

    // You can access other providers in methods too
    // final api = ref.read(apiClientProvider);
    // final list = await api.getAreaRadiusList();

    try {
      state = state.copyWith(areaRadiusList: [
        AreaRadiusModel.fromJson({'zoomLevel': 14.0, 'circleRadius': 1000.0}),
        AreaRadiusModel.fromJson({'zoomLevel': 13.0, 'circleRadius': 2000.0}),
        AreaRadiusModel.fromJson({'zoomLevel': 12.4, 'circleRadius': 3000.0}),
        AreaRadiusModel.fromJson({'zoomLevel': 12.0, 'circleRadius': 4000.0})
      ]);
    } catch (e) {
      print(e);
    }
  }

  void _fetchMyAreaRadius() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final serverRadius = AreaRadiusModel.fromJson({'zoomLevel': 13.0, 'circleRadius': 2000.0});
      // Find matching index in our list
      final index = state.areaRadiusList.indexWhere((element) => element.zoomLevel == serverRadius.zoomLevel && element.circleRadius == serverRadius.circleRadius);

      if (index != -1) {
        state = state.copyWith(selectedIndex: index);
      }
    } catch (e) {
      print(e);
    }
  }
}

final areaSettingsProvider = NotifierProvider<MyAreaSettingsNotifier, MyAreaSettingsState>(() {
  return MyAreaSettingsNotifier();
});
