import 'package:flutter/material.dart';
import '../../utils/app_routes.dart';

class BottomNavItem {
  final IconData icon;
  final String label;
  final String route;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

final List<BottomNavItem> navItems = [
    const BottomNavItem(
      icon: Icons.home,
      label: 'Home',
      route: AppRoutes.home,
    ),
    const BottomNavItem(
      icon: Icons.search,
      label: 'Search',
      route: AppRoutes.search,
    ),
    const BottomNavItem(
      icon: Icons.calendar_month_outlined,
      label: 'Bookings',
      route: AppRoutes.bookings,
    ),
    const BottomNavItem(
      icon: Icons.person,
      label: 'Profile',
      route: AppRoutes.profile,
    ),
  ];