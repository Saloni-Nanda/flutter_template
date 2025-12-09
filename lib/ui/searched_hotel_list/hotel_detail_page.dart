// room_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/theme/theme.dart';
import 'hotel_card.dart';
import 'room.dart';
import 'booking_page.dart';
import '../../common/models/hotel_search_data.dart';


class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;
  final HotelSearchData searchData;

  const HotelDetailPage({
    Key? key,
    required this.hotel,
    required this.searchData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample rooms for the hotel
    final List<Room> rooms = [
      Room(
        id: 'ROOM001',
        name: 'Deluxe King Room',
        description: 'Spacious room with king bed, city view, and modern amenities.',
        images: ['https://picsum.photos/800/600?random=22', 'https://picsum.photos/800/600?random=23'],
        maxGuests: 2,
        pricePerNight: 150.0,
        isAvailable: true,
      ),
      Room(
        id: 'ROOM002',
        name: 'Standard Double Room',
        description: 'Comfortable room with two beds, perfect for families.',
        images: ['https://picsum.photos/800/600?random=24', 'https://picsum.photos/800/600?random=25'],
        maxGuests: 4,
        pricePerNight: 120.0,
        isAvailable: true,
      ),
      Room(
        id: 'ROOM003',
        name: 'Suite with Balcony',
        description: 'Luxurious suite with private balcony and premium services.',
        images: ['https://picsum.photos/800/600?random=26', 'https://picsum.photos/800/600?random=27'],
        maxGuests: 3,
        pricePerNight: 200.0,
        isAvailable: false,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hotel.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Images Carousel
            _buildPropertyImagesCarousel(),

            // Property Details Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Name and Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _buildStarRating(hotel.starRating),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.secondary.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'From \$${hotel.startingPrice}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondary,
                              ),
                            ),
                            Text(
                              'per night',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColor.primary.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: AppColor.primary.withOpacity(0.7),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          hotel.city,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.primary.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Property Description
                  Text(
                    'About Property',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    hotel.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.primary.withOpacity(0.7),
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Ratings & Reviews
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[200]!,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ratings & Reviews',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Customer Rating
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  hotel.customerRating != null
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColor.ratingColor,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${hotel.customerRating}',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primary,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          'No Rating',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColor.primary.withOpacity(0.6),
                                          ),
                                        ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Customer Rating',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.primary.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Reviews
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotel.reviewCount > 0
                                        ? '${hotel.reviewCount} Reviews'
                                        : 'No Reviews Yet',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hotel.reviewCount > 0
                                        ? 'Read what our guests say'
                                        : 'Be the first to review',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.primary.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Contact Information
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[200]!,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Information',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: AppColor.primary,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.primary.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hotel.contactNumber,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Implement call functionality
                              },
                              icon: Icon(
                                Icons.call,
                                color: AppColor.primary,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Amenities Section
                  Text(
                    'Amenities',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: hotel.amenities
                        .map((amenity) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColor.primary.withOpacity(0.1),
                                ),
                              ),
                              child: Text(
                                amenity,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 30),

                  // Available Rooms Section
                  Text(
                    'Available Rooms (${rooms.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select from our comfortable rooms',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primary.withOpacity(0.6),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Room Cards List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return _buildRoomCard(context, rooms[index]);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImagesCarousel() {
    return Container(
      height: 300,
      child: PageView.builder(
        itemCount: hotel.imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(
            hotel.imageUrls[index],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: AppColor.primary,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.hotel,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Image not available',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    final fullStars = rating.floor();
    final hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      children: [
        // Full Stars
        ...List.generate(fullStars, (index) => Icon(
          Icons.star,
          size: 20,
          color: AppColor.ratingColor,
        )),
        
        // Half Star if needed
        if (hasHalfStar)
          Icon(
            Icons.star_half,
            size: 20,
            color: AppColor.ratingColor,
          ),
        
        // Empty Stars
        ...List.generate(
          5 - fullStars - (hasHalfStar ? 1 : 0),
          (index) => Icon(
            Icons.star_border,
            size: 20,
            color: Colors.grey[300],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Rating Number
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCard(BuildContext context, Room room) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    room.images.isNotEmpty ? room.images.first : '',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: room.images.isEmpty
                  ? Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.bed,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : null,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room Name and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        room.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${room.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondary,
                          ),
                        ),
                        Text(
                          'per night',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.primary.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Room Description
                Text(
                  room.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.primary.withOpacity(0.7),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                // Guest Capacity and Availability
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Guest Capacity
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 18,
                          color: AppColor.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Max ${room.maxGuests} guests',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Availability Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: room.isAvailable
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            room.isAvailable
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 14,
                            color: room.isAvailable ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            room.isAvailable ? 'Available' : 'Booked',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: room.isAvailable
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Book Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: room.isAvailable
                        ? () {
                            Get.to(() => BookingPage(
                              hotel: hotel,
                              room: room,
                              searchData: searchData,
                            ));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: room.isAvailable
                          ? AppColor.primary
                          : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                    icon: Icon(
                      Icons.book,
                      color: room.isAvailable ? Colors.white : Colors.grey[600],
                      size: 20,
                    ),
                    label: Text(
                      room.isAvailable ? 'Book Now' : 'Not Available',
                      style: TextStyle(
                        color: room.isAvailable ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}