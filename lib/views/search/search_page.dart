import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/search_widget/search_widget.dart';
import '../../ui/bottom_navbar/bottom_navbar.dart';
import '../../common/bottom_navitem/bottom_navitem_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1;

  void _onNavTap(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      Get.toNamed(navItems[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to home instead of closing app
        setState(() => _currentIndex = 0);
        Get.toNamed(navItems[0].route);
        return false; // Prevent default back behavior
      },
      child: Scaffold(
        body: HotelSearchWidget(
          initialData: Get.arguments,
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
