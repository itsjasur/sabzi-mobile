import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';

class MyAreaSettingsState {
  final AreaRadiusModel? selectedAreaRadius;
  final int selectedAreaIndex;
  final List<AreaRadiusModel> areaRadiusList;

  MyAreaSettingsState({
    required this.selectedAreaRadius,
    required this.areaRadiusList,
    required this.selectedAreaIndex,
  });

  MyAreaSettingsState copyWith({
    AreaRadiusModel? selectedAreaRadius,
    List<AreaRadiusModel>? areaRadiusList,
    int? selectedAreaIndex,
  }) {
    return MyAreaSettingsState(
      selectedAreaRadius: selectedAreaRadius ?? this.selectedAreaRadius,
      areaRadiusList: areaRadiusList ?? this.areaRadiusList,
      selectedAreaIndex: selectedAreaIndex ?? this.selectedAreaIndex,
    );
  }
}
