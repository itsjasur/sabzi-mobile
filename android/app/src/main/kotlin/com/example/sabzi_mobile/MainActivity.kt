package com.example.sabzi_mobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory;


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("402ef709-b76a-4c64-8e9c-c7e25f4dd4de")  
        super.configureFlutterEngine(flutterEngine)
        // MapKitFactory.setLocale("YOUR_LOCALE")  
    }
}