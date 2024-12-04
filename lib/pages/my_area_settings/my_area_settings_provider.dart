import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_state.dart';

class MyAreaSettingsProvider extends StateNotifier<MyAreaSettingsState> {
  MyAreaSettingsProvider() : super(MyAreaSettingsState(selectedAreaRadius: AreaRadius.large)) {
    _fetchMyAreaInfo();
  }

  void updateSliderValue(double value) {
    state = state.copyWith(selectedAreaRadius: AreaRadius.values[value.toInt()]);
  }

  Future<void> _fetchMyAreaInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      // state = state.copyWith(selectedAreaRadius: AreaRadius.medium);
      state = state.copyWith(selectedAreaRadius: AreaRadius.fromString('small'));
    } catch (e) {
      print(e);
    }
  }
}

final areaSettingsProvider = StateNotifierProvider<MyAreaSettingsProvider, MyAreaSettingsState>((ref) {
  return MyAreaSettingsProvider();
});
