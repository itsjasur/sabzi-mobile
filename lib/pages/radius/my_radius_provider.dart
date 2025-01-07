import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/radius/my_radius_state.dart';

class MyRadiusProvider extends Notifier<MyRadiusState> {
  @override
  MyRadiusState build() {
    ref.onDispose(() {});

    Future.microtask(() async {
      _fetchMyRadiusSettings();
    });

    return MyRadiusState(
      radiuses: [3000, 6000, 9000, 12000],
      zoomLevels: [12.6, 11.7, 11.1, 10.7],
      currentIndex: 0,
    );
  }

  void changeIndex(double index) {
    state = state.copyWith(currentIndex: index);
    // TODO:
    // API CALL HERE TO UPDATE USER RADIUS SETTINGS
  }

  void _fetchMyRadiusSettings() {
    // TODO:
    // API CALL HERE TO FETCH USER RADIUS SETTINGS
  }
}

final myRadiusProvider = NotifierProvider<MyRadiusProvider, MyRadiusState>(() => MyRadiusProvider());
