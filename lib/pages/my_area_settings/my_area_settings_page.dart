import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/my_area_settings/yandex.dart';

class MyAreaSettingsPage extends ConsumerWidget {
  const MyAreaSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey.shade50,
                height: 620,
                width: double.infinity,
                child: const YandexMapView(
                  latitude: 55.751225,
                  longitude: 37.62954,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
