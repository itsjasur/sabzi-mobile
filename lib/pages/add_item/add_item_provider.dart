import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/add_item/add_item_state.dart';

class AddItemProvider extends Notifier<AddItemState> {
  @override
  AddItemState build() {
    return AddItemState();
  }
}
