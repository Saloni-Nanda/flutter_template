import 'package:flutter/material.dart';
import 'package:hotel_paradise/common/theme/theme.dart';

class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final bool isTrending;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    this.isTrending = false,
  });
}

class PopularDestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback? onTap;
  final VoidCallback? onExploreTap;
  final VoidCallback? onBookmarkTap;

  const PopularDestinationCard({
    super.key,
    required this.destination,
    this.onTap,
    this.onExploreTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColor.cardBorder,
            width: 1,
          ),
        ),
          child: Column(
            children: [
              // Image and Overlay Section
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      destination.imageUrl,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Trending Badge
                  if (destination.isTrending)
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.secondary,
                              Color.fromARGB(255, 200, 150, 70),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.trending_up,
                                color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              'Trending',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    destination.name,
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    destination.country,
                                    style: TextStyle(
                                      color: AppColor.textLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Description
                              Text(
                                destination.description,
                                style: TextStyle(
                                  color: AppColor.textLight,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Explore Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: onExploreTap,
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
