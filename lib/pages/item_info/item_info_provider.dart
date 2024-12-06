import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/item_info/item_info_state.dart';

class ItemInfoProvider extends Notifier<ItemInfoState> {
  @override
  ItemInfoState build() {
    _fetchIteminfo();
    return ItemInfoState(itemId: 0, isInfoLoaded: false);
  }

  void _fetchIteminfo() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      state = state.copyWith(isInfoLoaded: true);
    } catch (e) {
      print(e);
    }
  }
}

final itemInfoProvider = NotifierProvider<ItemInfoProvider, ItemInfoState>(() {
  return ItemInfoProvider();
});
