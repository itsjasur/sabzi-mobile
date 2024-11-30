import 'package:flutter_sabzi/core/models/area_model.dart';

class AreaState {
  final List<AreaModel> areas;
  final int selectedAreaId;

  AreaState({
    required this.areas,
    required this.selectedAreaId,
  });

  AreaState copyWith({
    List<AreaModel>? areas,
    int? selectedAreaId,
  }) {
    return AreaState(
      areas: areas ?? this.areas,
      selectedAreaId: selectedAreaId ?? this.selectedAreaId,
    );
  }
}
