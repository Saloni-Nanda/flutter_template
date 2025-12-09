import 'package:flutter/material.dart';
import 'package:hotel_paradise/ui/popular_destination/all_destination.dart';
import '../../common/theme/theme.dart';
import 'popular_destination_card.dart';

// Mock Data for Homepage
final List<Destination> mockDestinations = [
  Destination(
    id: '1',
    name: 'Bali',
    country: 'Indonesia',
    imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
    description: 'Tropical paradise with beautiful beaches and rich culture',
    isTrending: true,
    pricePerPerson: '\$58',
  ),
  Destination(
    id: '2',
    name: 'Kyoto',
    country: 'Japan',
    imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
    description: 'Historic city with ancient temples and traditional gardens',
    isTrending: true,
    pricePerPerson: '\$72',
  ),
  Destination(
    id: '3',
    name: 'Santorini',
    country: 'Greece',
    imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
    description: 'Stunning white-washed buildings with breathtaking views',
    pricePerPerson: '\$95',
  ),
  Destination(
    id: '4',
    name: 'Swiss Alps',
    country: 'Switzerland',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    description: 'Majestic mountains and pristine alpine landscapes',
    pricePerPerson: '\$110',
  ),
  Destination(
    id: '5',
    name: 'Maldives',
    country: 'Maldives',
    imageUrl: 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?w=800',
    description: 'Overwater bungalows and crystal clear waters',
    isTrending: true,
    pricePerPerson: '\$145',
  ),
  Destination(
    id: '6',
    name: 'Paris',
    country: 'France',
    imageUrl: 'https://images.unsplash.com/photo-1509439581779-6298f75bf6e5?w=800',
    description: 'The city of love with iconic landmarks and cuisine',
    pricePerPerson: '\$85',
  ),
  Destination(
    id: '7',
    name: 'New York',
    country: 'USA',
    imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800',
    description: 'The city that never sleeps with endless entertainment',
    pricePerPerson: '\$92',
  ),
];

class PopularDestination extends StatefulWidget {
  final String title;
  final List<Destination> destinations;
  final VoidCallback? onSeeAllTap;
  final Function(Destination)? onExploreTap;

  const PopularDestination({
    super.key,
    required this.title,
    required this.destinations,
    this.onSeeAllTap,
    this.onExploreTap,
  });

  @override
  State<PopularDestination> createState() => _PopularDestinationState();
}

class _PopularDestinationState extends State<PopularDestination> {
  final ScrollController _scrollController = ScrollController();
  int _centerIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double itemWidth = 220 + 16; // card width + padding
    final double offset = _scrollController.offset + 20; // account for initial padding
    final int centerIndex = (offset / itemWidth).round();
    
    if (centerIndex != _centerIndex && centerIndex >= 0 && centerIndex < widget.destinations.length) {
      setState(() {
        _centerIndex = centerIndex;
      });
    }
  }

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
                widget.title,
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllDestinationsPage(),
                    ),
                  );
                },
                child: const Text(
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
          height: 250,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: widget.destinations.length,
            itemBuilder: (context, index) {
              final destination = widget.destinations[index];
              final isInView = index == _centerIndex;
              
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PopularDestinationCard(
                  destination: destination,
                  isInView: isInView,
                  onExploreTap: () => widget.onExploreTap?.call(destination),
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