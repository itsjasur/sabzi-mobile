import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';

class MyAreaSettingsState {
  final AreaRadius selectedAreaRadius;

  MyAreaSettingsState({required this.selectedAreaRadius});

  MyAreaSettingsState copyWith({AreaRadius? selectedAreaRadius}) {
    return MyAreaSettingsState(
      selectedAreaRadius: selectedAreaRadius ?? this.selectedAreaRadius,
    );
  }
}
