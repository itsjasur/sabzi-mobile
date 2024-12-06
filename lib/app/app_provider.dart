import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/app/app_state.dart';

class AppProvider extends Notifier<AppState> {
  @override
  AppState build() {
    return AppState(isGlobalLoading: false);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isGlobalLoading: isLoading);
  }
}

final appProvider = NotifierProvider<AppProvider, AppState>(() {
  return AppProvider();
});
