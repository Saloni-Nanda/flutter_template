import 'package:flutter/material.dart';
import 'hotel_card.dart';

class HotelList extends StatelessWidget {
   final void Function(Hotel)? onHotelTap;

   HotelList({Key? key, this.onHotelTap}) : super(key: key);

  final List<Hotel> _hotels = [
    Hotel(
      id: 'HOT001',
      name: 'Grand Paradise Resort & Spa',
      city: 'Bali, Indonesia',
      imageUrls: [
        'https://picsum.photos/800/600?random=1',
        'https://picsum.photos/800/600?random=2',
        'https://picsum.photos/800/600?random=3',
      ],
      starRating: 5.0,
      customerRating: 4.8,
      reviewCount: 1247,
      description: 'Luxurious 5-star beachfront resort with infinity pools, world-class spa, and multiple dining options overlooking the Indian Ocean.',
      startingPrice : 450.00,
      contactNumber: '+62 361 847 3333',
      amenities: ['Free WiFi', 'Swimming Pool', 'Spa', 'Restaurant', 'Bar', 'Gym', 'Parking', 'Beach Access'],
    ),
    Hotel(
      id: 'HOT002',
      name: 'Tokyo Skyline Hotel',
      city: 'Tokyo, Japan',
      imageUrls: [
        'https://picsum.photos/800/600?random=4',
        'https://picsum.photos/800/600?random=5',
      ],
      starRating: 4.5,
      customerRating: 4.6,
      reviewCount: 892,
      description: 'Modern high-rise hotel in Shibuya with panoramic city views, premium amenities, and easy access to metro stations.',
      startingPrice : 320.00,
      contactNumber: '+81 3 5459 7000',
      amenities: ['Free WiFi', 'Restaurant', 'Business Center', 'Concierge', 'Room Service', 'Laundry'],
    ),
    Hotel(
      id: 'HOT003',
      name: 'Parisian Heritage Hotel',
      city: 'Paris, France',
      imageUrls: [
        'https://picsum.photos/800/600?random=6',
        'https://picsum.photos/800/600?random=7',
      ],
      starRating: 4.0,
      customerRating: 4.3,
      reviewCount: 654,
      description: 'Charming boutique hotel in the Latin Quarter with antique furnishings, Eiffel Tower views, and authentic French breakfast.',
      startingPrice : 280.00,
      contactNumber: '+33 1 40 46 72 00',
      amenities: ['Free WiFi', 'Breakfast', 'Bar', 'Terrace', 'Luggage Storage', 'Tour Desk'],
    ),
    Hotel(
      id: 'HOT004',
      name: 'New York Central Plaza',
      city: 'New York, USA',
      imageUrls: [
        'https://picsum.photos/800/600?random=8',
        'https://picsum.photos/800/600?random=9',
      ],
      starRating: 4.0,
      customerRating: 4.5,
      reviewCount: 2105,
      description: 'Contemporary hotel in Manhattan with direct subway access, business facilities, and Central Park proximity.',
      startingPrice : 380.00,
      contactNumber: '+1 212-581-8100',
      amenities: ['Free WiFi', 'Fitness Center', 'Business Center', 'Restaurant', '24-hour Front Desk', 'Valet Parking'],
    ),
    Hotel(
      id: 'HOT005',
      name: 'Royal Garden Hotel',
      city: 'London, UK',
      imageUrls: [
        'https://picsum.photos/800/600?random=10',
        'https://picsum.photos/800/600?random=11',
      ],
      starRating: 5.0,
      customerRating: 4.9,
      reviewCount: 1876,
      description: 'Luxury hotel overlooking Kensington Gardens with afternoon tea service, fine dining restaurants, and chauffeur service.',
      startingPrice : 550.00,
      contactNumber: '+44 20 7373 8000',
      amenities: ['Free WiFi', 'Spa', 'Restaurants', 'Bar', 'Gym', 'Parking', 'Room Service', 'Concierge'],
    ),
    Hotel(
      id: 'HOT006',
      name: 'Sydney Harbour Suites',
      city: 'Sydney, Australia',
      imageUrls: [
        'https://picsum.photos/800/600?random=12',
        'https://picsum.photos/800/600?random=13',
      ],
      starRating: 4.5,
      customerRating: 4.7,
      reviewCount: 943,
      description: 'Waterfront hotel with Opera House views, rooftop pool, and premium suites with private balconies.',
      startingPrice : 420.00,
      contactNumber: '+61 2 9256 4000',
      amenities: ['Free WiFi', 'Swimming Pool', 'Restaurant', 'Bar', 'Gym', 'Spa', 'Beach Access'],
    ),
    Hotel(
      id: 'HOT007',
      name: 'Dubai Desert Oasis',
      city: 'Dubai, UAE',
      imageUrls: [
        'https://picsum.photos/800/600?random=14',
        'https://picsum.photos/800/600?random=15',
      ],
      starRating: 5.0,
      customerRating: 4.8,
      reviewCount: 1765,
      description: 'Ultra-luxurious desert resort with private villas, camel rides, traditional spa, and desert safari experiences.',
      startingPrice : 650.00,
      contactNumber: '+971 4 501 8888',
      amenities: ['Free WiFi', 'Swimming Pool', 'Spa', 'Restaurants', 'Desert Activities', 'Private Villas', 'Butler Service'],
    ),
    Hotel(
      id: 'HOT008',
      name: 'Marina Bay Sands',
      city: 'Singapore',
      imageUrls: [
        'https://picsum.photos/800/600?random=16',
        'https://picsum.photos/800/600?random=17',
      ],
      starRating: 5.0,
      customerRating: 4.9,
      reviewCount: 3142,
      description: 'Iconic integrated resort with infinity pool, observation deck, casino, shopping mall, and celebrity chef restaurants.',
      startingPrice : 580.00,
      contactNumber: '+65 6688 8868',
      amenities: ['Free WiFi', 'Infinity Pool', 'Casino', 'Shopping Mall', 'Restaurants', 'Spa', 'Observation Deck'],
    ),
    Hotel(
      id: 'HOT009',
      name: 'Bangkok Riverside Palace',
      city: 'Bangkok, Thailand',
      imageUrls: [
        'https://picsum.photos/800/600?random=18',
        'https://picsum.photos/800/600?random=19',
      ],
      starRating: 5.0,
      customerRating: 4.7,
      reviewCount: 1890,
      description: 'Traditional Thai-style hotel on Chao Phraya River with river view rooms, traditional massage, and boat shuttle service.',
      startingPrice : 290.00,
      contactNumber: '+66 2 659 9000',
      amenities: ['Free WiFi', 'Swimming Pool', 'Spa', 'Restaurant', 'River View', 'Boat Shuttle', 'Cultural Shows'],
    ),
    Hotel(
      id: 'HOT010',
      name: 'Colosseum View Hotel',
      city: 'Rome, Italy',
      imageUrls: [
        'https://picsum.photos/800/600?random=20',
        'https://picsum.photos/800/600?random=21',
      ],
      starRating: 4.0,
      customerRating: 4.4,
      reviewCount: 876,
      description: 'Historic hotel with Colosseum views, rooftop restaurant serving Italian cuisine, and walking distance to ancient sites.',
      startingPrice : 320.00,
      contactNumber: '+39 06 482 7444',
      amenities: ['Free WiFi', 'Rooftop Restaurant', 'Bar', 'Terrace', 'Tour Desk', 'Bicycle Rental'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _hotels.length,
        itemBuilder: (context, index) {
          final hotel = _hotels[index];
          return HotelCard(
            hotel: hotel,
            onViewRooms: () => onHotelTap?.call(hotel),
            onFavorite: () {

            },
            onTap: () => onHotelTap?.call(hotel),
          );
        },
      ),
    );
  }

}