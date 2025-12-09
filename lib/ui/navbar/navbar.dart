import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/theme/theme.dart';

class Navbar extends StatefulWidget {
  final VoidCallback? onSearchTap;
  final int notificationCount;
  final int wishlistCount;
  final String userName;
  final double searchBarOverlap;

  const Navbar({
    Key? key,
    this.onSearchTap,
    this.notificationCount = 3,
    this.wishlistCount = 3,
    this.userName = "User",
    this.searchBarOverlap = 20.0,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140, // Total height: 100 + 40 (search bar height approx)
      child: Stack(
        children: [
          // Main navbar container
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.secondary,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: _buildTopBar(),
            ),
          ),

          // Search bar positioned with overlap
          Positioned(
            top: 100 - widget.searchBarOverlap, // 80
            left: 16,
            right: 16,
            child: _buildHotelSearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.secondary, // Secondary background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Brand Logo Section
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  AppColor.primary,
                  AppColor.primary.withValues(alpha:0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withValues(alpha:0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // User Welcome Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                        .withValues(alpha:0.8), // Lighter text for contrast
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ' ${widget.userName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white, // White text for contrast
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Action Icons
          Row(
            children: [
              _buildActionIcon(
                icon: Icons.favorite_border_rounded,
                count: widget.wishlistCount,
                badgeColor: Colors.redAccent,
                onTap: () => Get.toNamed('/wishlist'),
              ),
              const SizedBox(width: 12),
              _buildActionIcon(
                icon: Icons.notifications_outlined,
                count: widget.notificationCount,
                badgeColor: AppColor.primary,
                onTap: () => Get.toNamed('/notifications'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: GestureDetector(
        onTap: widget.onSearchTap ?? () => Get.toNamed('/search'),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha:0.3), // Softer border
              width: 1.5,
            ),
            
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: AppColor.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Find Your Perfect Stay',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600, // Slightly bolder
                          color: AppColor.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Hotels • Resorts • Apartments',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors
                              .grey.shade600, // Darker for better readability
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColor.primary.withValues(alpha:0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required int count,
    required Color badgeColor,
    required VoidCallback onTap,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                Colors.white.withValues(alpha:0.9), // White with slight transparency
            border: Border.all(
              color: Colors.white.withValues(alpha:0.4),
              width: 1.5,
            ),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 18,
              color: AppColor.primary, // Primary color for icons
            ),
            onPressed: onTap,
            splashRadius: 20,
          ),
        ),
        if (count > 0)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withValues(alpha:0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
