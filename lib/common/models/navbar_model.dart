import 'package:flutter/material.dart';

class NavbarModel {
  final VoidCallback? onSearchTap;
  final int notificationCount;
  final int wishlistCount;
  final String userName;
  final double searchBarOverlap;

  const NavbarModel({
    this.onSearchTap,
    this.notificationCount = 3,
    this.wishlistCount = 3,
    this.userName = "User",
    this.searchBarOverlap = 20.0,
  });
}