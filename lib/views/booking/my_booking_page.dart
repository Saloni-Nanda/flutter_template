import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/bottom_navbar/bottom_navbar.dart';
import '../../common/bottom_navitem/bottom_navitem_list.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({super.key});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  int _currentIndex = 2; // Bookings index

  void _onNavTap(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      Get.toNamed(navItems[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Bookings Page - Work in Progress")),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        items: navItems,
      ),
    );
  }
}
