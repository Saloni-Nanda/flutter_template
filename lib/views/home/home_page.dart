
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../ui/popular_destination/popular_destination.dart';
import '../../common/theme/theme.dart';
import '../../ui/navbar/navbar.dart';
import '../../ui/banner/banner.dart' as banner;
import '../../ui/bottom_navbar/bottom_navbar.dart';
import '../../common/bottom_navitem/bottom_navitem_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      Get.offAllNamed(navItems[index].route);
    }
  }

  void _handleSearchTap() async {
    // Navigate to search page and wait for result
    Get.toNamed('/search');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Close the app when back is pressed on home page
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Navbar with search functionality
                Navbar(
                  onSearchTap: _handleSearchTap,
                  notificationCount: 3,
                  wishlistCount: 5,
                  userName: "John Doe", // Replace with actual user name
                ),
                SizedBox(height: 16),
                banner.Banner(),

                SizedBox(height: 16),

                PopularDestination(
                  title: 'Popular Destinations',
                  destinations: mockDestinations,
                  onExploreTap: (destination) {
                    Get.toNamed('/search', arguments: destination.name);
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavbar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          items: navItems,
        ),
      ),
    );
  }
}