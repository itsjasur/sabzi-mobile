import 'package:flutter_sabzi/core/models/area_model.dart';
import 'package:flutter_sabzi/pages/my_area_settings/my_area_settings_models.dart';

class AreaState {
  final List<AreaModel> areas;
  final int selectedAreaId;
  final AreaRadius? selectedAreaRadius;

  AreaState({
    required this.areas,
    required this.selectedAreaId,
    this.selectedAreaRadius,
  });

  AreaState copyWith({
    List<AreaModel>? areas,
    int? selectedAreaId,
    AreaRadius? selectedAreaRadius,
  }) {
    return AreaState(
      areas: areas ?? this.areas,
      selectedAreaId: selectedAreaId ?? this.selectedAreaId,
      selectedAreaRadius: this.selectedAreaRadius,
    );
  }
}
