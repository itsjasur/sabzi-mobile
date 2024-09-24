import 'package:flutter/material.dart';

class NavItem {
  final Widget page;
  final String label;
  final IconData icon;
  final IconData activeIcon;

  NavItem({required this.page, required this.label, required this.icon, required this.activeIcon});
}
