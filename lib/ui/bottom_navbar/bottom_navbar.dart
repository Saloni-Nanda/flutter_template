import 'package:flutter/material.dart';
import '../../../common/theme/theme.dart';
import '../../../common/bottom_navitem/bottom_navitem_list.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bottomBarBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, -8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              widget.items.length,
              (index) => _NavItem(
                icon: widget.items[index].icon,
                label: widget.items[index].label,
                isActive: widget.currentIndex == index,
                onTap: () => widget.onTap(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _NavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: isActive ? 8 : 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColor.bottomBarBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
        ? [
            const BoxShadow(
              color: Colors.white,
              blurRadius: 18,
              offset: const Offset(-3, -3),
            ),
            BoxShadow(
              color: AppColor.bottomBarSelected.withValues(alpha:0.15),
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ]
        : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isActive ? 1.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Icon(
                icon,
                color: isActive
                    ? AppColor.bottomBarIconSelected
                    : AppColor.bottomBarIconUnselected,
                size: 24,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.bottomBarSelected,
                          letterSpacing: 0.3,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
