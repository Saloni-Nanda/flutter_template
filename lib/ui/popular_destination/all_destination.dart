import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_paradise/common/theme/theme.dart';
import 'popular_destination_card.dart';

// Extended Mock Data for All Destinations Page
final List<Destination> allDestinations = [
  Destination(
    id: '1',
    name: 'Bali',
    country: 'Indonesia',
    imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
    description: 'Tropical paradise with beautiful beaches and rich culture',
    isTrending: true,
    pricePerPerson: '\$58',
    rating: 4.8,
  ),
  Destination(
    id: '2',
    name: 'Kyoto',
    country: 'Japan',
    imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
    description: 'Historic city with ancient temples and traditional gardens',
    isTrending: true,
    pricePerPerson: '\$72',
    rating: 4.9,
  ),
  Destination(
    id: '3',
    name: 'Santorini',
    country: 'Greece',
    imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
    description: 'Stunning white-washed buildings with breathtaking views',
    pricePerPerson: '\$95',
    rating: 4.7,
  ),
  Destination(
    id: '4',
    name: 'Swiss Alps',
    country: 'Switzerland',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    description: 'Majestic mountains and pristine alpine landscapes',
    pricePerPerson: '\$110',
    rating: 4.6,
  ),
  Destination(
    id: '5',
    name: 'Maldives',
    country: 'Maldives',
    imageUrl: 'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?w=800',
    description: 'Overwater bungalows and crystal clear waters',
    isTrending: true,
    pricePerPerson: '\$145',
    rating: 4.9,
  ),
  Destination(
    id: '6',
    name: 'Paris',
    country: 'France',
    imageUrl: 'https://images.unsplash.com/photo-1509439581779-6298f75bf6e5?w=800',
    description: 'The city of love with iconic landmarks and cuisine',
    pricePerPerson: '\$85',
    rating: 4.8,
  ),
  Destination(
    id: '7',
    name: 'New York',
    country: 'USA',
    imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800',
    description: 'The city that never sleeps with endless entertainment',
    pricePerPerson: '\$92',
    rating: 4.7,
  ),
  Destination(
    id: '8',
    name: 'Trolltunga',
    country: 'Norway',
    imageUrl: 'https://images.unsplash.com/photo-1601439678777-b2b3c56fa627?w=800',
    description: 'Breathtaking cliff overlooking pristine fjords',
    pricePerPerson: '\$48',
    rating: 4.8,
  ),
  Destination(
    id: '9',
    name: 'Iceland',
    country: 'Iceland',
    imageUrl: 'https://images.unsplash.com/photo-1504893524553-b855bce32c67?w=800',
    description: 'Land of fire and ice with stunning natural wonders',
    isTrending: true,
    pricePerPerson: '\$125',
    rating: 4.9,
  ),
  Destination(
    id: '10',
    name: 'Dubai',
    country: 'UAE',
    imageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800',
    description: 'Luxury destination with modern architecture and shopping',
    pricePerPerson: '\$98',
    rating: 4.6,
  ),
  Destination(
    id: '11',
    name: 'Barcelona',
    country: 'Spain',
    imageUrl: 'https://images.unsplash.com/photo-1583422409516-2895a77efded?w=800',
    description: 'Vibrant city with stunning architecture and beaches',
    pricePerPerson: '\$68',
    rating: 4.7,
  ),
  Destination(
    id: '12',
    name: 'Rome',
    country: 'Italy',
    imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=800',
    description: 'Ancient city with rich history and incredible cuisine',
    pricePerPerson: '\$75',
    rating: 4.8,
  ),
  Destination(
    id: '13',
    name: 'Machu Picchu',
    country: 'Peru',
    imageUrl: 'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800',
    description: 'Ancient Incan citadel in the Andes mountains',
    isTrending: true,
    pricePerPerson: '\$88',
    rating: 4.9,
  ),
  Destination(
    id: '14',
    name: 'London',
    country: 'United Kingdom',
    imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=800',
    description: 'Historic capital with iconic landmarks and culture',
    pricePerPerson: '\$82',
    rating: 4.6,
  ),
  Destination(
    id: '15',
    name: 'Bangkok',
    country: 'Thailand',
    imageUrl: 'https://images.unsplash.com/photo-1563492065599-3520f775eeed?w=800',
    description: 'Bustling city with temples, street food and nightlife',
    pricePerPerson: '\$45',
    rating: 4.7,
  ),
];

class AllDestinationsPage extends StatefulWidget {
  const AllDestinationsPage({super.key});

  @override
  State<AllDestinationsPage> createState() => _AllDestinationsPageState();
}

class _AllDestinationsPageState extends State<AllDestinationsPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Trending', 'Popular', 'Budget', 'Luxury'];

  List<Destination> get _filteredDestinations {
    if (_selectedFilter == 'All') {
      return allDestinations;
    } else if (_selectedFilter == 'Trending') {
      return allDestinations.where((d) => d.isTrending).toList();
    } else if (_selectedFilter == 'Popular') {
      return allDestinations.where((d) => d.rating >= 4.0).toList();
    } else if (_selectedFilter == 'Budget') {
      return allDestinations.where((d) {
        final price = int.tryParse(d.pricePerPerson.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
        return price < 60;
      }).toList();
    } else if (_selectedFilter == 'Luxury') {
      return allDestinations.where((d) {
        final price = int.tryParse(d.pricePerPerson.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
        return price >= 100;
      }).toList();
    }
    return allDestinations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Destinations',
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColor.primary),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppColor.secondary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColor.primary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColor.secondary : AppColor.cardBorder,
                    ),
                  ),
                );
              },
            ),
          ),
          // Grid View
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredDestinations.length,
              itemBuilder: (context, index) {
                final destination = _filteredDestinations[index];
                return PopularDestinationCard(
                  destination: destination,
                  onExploreTap: () {
                    // Navigate to destination details
                   Get.toNamed('/search', arguments: destination.name);
                  },
                  showTrendingBadge: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}