import 'package:flutter/material.dart';
import 'package:uicons/uicons.dart';

class Category {
  final int id;
  final String code;
  final String name;
  final int priority;
  late Icon icon;
  final String? imagUrl;

  Category({
    required this.id,
    required this.name,
    required this.code,
    required this.priority,
    required this.imagUrl,
  }) {
    icon = _getIconFromCode(code);
  }

  Icon _getIconFromCode(String code) {
    switch (code) {
      case 'all':
        return Icon(UIcons.regularRounded.menu_burger);
      case 'electronics':
        return Icon(UIcons.regularRounded.smartphone);
      case 'appliances':
        return Icon(UIcons.regularRounded.guitar);
      case 'vehicles':
        return Icon(UIcons.regularRounded.car);
      case 'furniture':
        return Icon(UIcons.regularRounded.bed);
      case 'clothing':
        return const Icon(Icons.checkroom);
      case 'books':
        return Icon(UIcons.regularRounded.book);
      default:
        return Icon(UIcons.regularRounded.apps_add);
    }
  }
}
