import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemInfoPage extends ConsumerWidget {
  const ItemInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            // image
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
