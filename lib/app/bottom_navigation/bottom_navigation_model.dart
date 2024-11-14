//bottom_navigation_model.dart

import 'package:flutter/material.dart';

class BottomNavigationModel {
  final Widget page;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  BottomNavigationModel({required this.page, required this.label, required this.icon, required this.activeIcon});
}
