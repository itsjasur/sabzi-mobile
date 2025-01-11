import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/my_area/my_area_state.dart';

class MyAreaProvider extends Notifier<MyAreaState> {
  @override
  MyAreaState build() {
    ref.onDispose(() {});

    Future.microtask(() async {
      _fetchMyAreaSettings();
    });

    return MyAreaState(
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

  void _fetchMyAreaSettings() {
    // TODO:
    // API CALL HERE TO FETCH USER RADIUS SETTINGS
  }
}

final myAreaProvider = NotifierProvider<MyAreaProvider, MyAreaState>(() => MyAreaProvider());
