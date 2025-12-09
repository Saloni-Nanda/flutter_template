import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_paradise/ui/booking/my_bookings_page.dart';
import '../../ui/bottom_navbar/bottom_navbar.dart';
import '../../common/bottom_navitem/bottom_navitem_list.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
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
      body: MyBookingsPage(),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        items: navItems,
      ),
    );
  }
}
