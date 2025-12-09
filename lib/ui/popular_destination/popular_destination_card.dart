import 'package:flutter/material.dart';
import 'package:hotel_paradise/common/theme/theme.dart';

class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final bool isTrending;
  final String pricePerPerson;
  final double rating;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    this.isTrending = false,
    this.pricePerPerson = '\$48',
    this.rating = 4.5,
  });
}

class PopularDestinationCard extends StatefulWidget {
  final Destination destination;
  final VoidCallback? onExploreTap;
  final bool isInView;
  final bool showTrendingBadge;

  const PopularDestinationCard({
    super.key,
    required this.destination,
    this.onExploreTap,
    this.isInView = false,
    this.showTrendingBadge = true,
  });

  @override
  State<PopularDestinationCard> createState() => _PopularDestinationCardState();
}

class _PopularDestinationCardState extends State<PopularDestinationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onExploreTap,
      child: Container(
        width: 220,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Image with Zoom Effect
              AnimatedScale(
                scale: widget.isInView ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                child: Image.network(
                  widget.destination.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Content at Bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Destination Name
                      Text(
                        widget.destination.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Country with Location Icon
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.destination.country,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Trending Badge
              if (widget.destination.isTrending && widget.showTrendingBadge)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.secondary,
                          Color(0xFFD4A356),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Trending',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}