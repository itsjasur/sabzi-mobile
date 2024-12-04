import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/models/area_model.dart';
import 'package:flutter_sabzi/pages/my_area_settings/area_button/area_state.dart';

class AreaProvider extends StateNotifier<AreaState> {
  AreaProvider() : super(AreaState(areas: [], selectedAreaId: 1)) {
    _fetchAreas();
  }

  void changeArea(int newId) {
    state = state.copyWith(selectedAreaId: newId);
  }

  void _fetchAreas() async {
    print('areas fetched ${DateTime.now()}');
    await Future.delayed(const Duration(seconds: 1));
    try {
      state = state.copyWith(areas: [
        AreaModel(id: 1, name: 'Blue city ${Random().nextInt(100)}', code: 'blc'),
        AreaModel(id: 2, name: 'Gold city ${Random().nextInt(100)}', code: 'glc'),
      ]);
      // final response = await _apiService.post('categories', {});
    } catch (e) {
      print(e);
    }
  }
}

final areaProvider = StateNotifierProvider<AreaProvider, AreaState>((ref) {
  return AreaProvider();
});
