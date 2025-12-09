import 'package:flutter/material.dart';
import '../../common/theme/theme.dart';
import 'popular_destination_card.dart';

// Mock Data
final List<Destination> mockDestinations = [
  Destination(
    id: '1',
    name: 'Bali',
    country: 'Indonesia',
    imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
    description: 'Tropical paradise with beautiful beaches and rich culture',
    isTrending: true,
  ),
  Destination(
    id: '2',
    name: 'Kyoto',
    country: 'Japan',
    imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
    description: 'Historic city with ancient temples and traditional gardens',
    isTrending: true,
  ),
  Destination(
    id: '3',
    name: 'Santorini',
    country: 'Greece',
    imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
    description: 'Stunning white-washed buildings with breathtaking views',
  ),
  Destination(
    id: '4',
    name: 'Swiss Alps',
    country: 'Switzerland',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    description: 'Majestic mountains and pristine alpine landscapes',
  ),
  Destination(
    id: '5',
    name: 'Maldives',
    country: 'Maldives',
    imageUrl: 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?w=800',
    description: 'Overwater bungalows and crystal clear waters',
    isTrending: true,
  ),
  Destination(
    id: '6',
    name: 'Paris',
    country: 'France',
    imageUrl: 'https://images.unsplash.com/photo-1509439581779-6298f75bf6e5?w=800',
    description: 'The city of love with iconic landmarks and cuisine',
  ),
  Destination(
    id: '7',
    name: 'New York',
    country: 'USA',
    imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800',
    description: 'The city that never sleeps with endless entertainment',
  ),
];

class PopularDestination extends StatelessWidget {
  final String title;
  final List<Destination> destinations;
  final VoidCallback? onSeeAllTap;
  final Function(Destination)? onDestinationTap;
  final Function(Destination)? onBookmarkTap;
  final Function(Destination)? onExploreTap;

  const PopularDestination({
    super.key,
    required this.title,
    required this.destinations,
    this.onSeeAllTap,
    this.onDestinationTap,
    this.onBookmarkTap,
    this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onSeeAllTap,
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Scroll List
        SizedBox(
          height: 310,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PopularDestinationCard(
                  destination: destination,
                  onTap: () => onDestinationTap?.call(destination),
                  onExploreTap: () => onExploreTap?.call(destination),
                  onBookmarkTap: () => onBookmarkTap?.call(destination),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}