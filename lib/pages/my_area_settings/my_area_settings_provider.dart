import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_state.dart';

class MyAreaSettingsProvider extends StateNotifier<MyAreaSettingsState> {
  MyAreaSettingsProvider()
      : super(MyAreaSettingsState(
          selectedAreaIndex: 0,
          areaRadiusList: [],
          selectedAreaRadius: const AreaRadiusModel(zoomLevel: 12, circleRadius: 0),
        )) {
    _fetchAreaRadiusList();
    _fetchMyAreaRadius();
  }

  void updateSliderValue(int value) {
    state = state.copyWith(selectedAreaIndex: value, selectedAreaRadius: state.areaRadiusList[value]);
  }

  void _fetchAreaRadiusList() async {
    await Future.delayed(const Duration(seconds: 1));
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
      // selectedAreaIndex and selectedAreaRadius both should be set from the fetched data
      state = state.copyWith(selectedAreaRadius: state.areaRadiusList[0], selectedAreaIndex: 0);
    } catch (e) {
      print(e);
    }
  }
}

final areaSettingsProvider = StateNotifierProvider<MyAreaSettingsProvider, MyAreaSettingsState>((ref) {
  return MyAreaSettingsProvider();
});
