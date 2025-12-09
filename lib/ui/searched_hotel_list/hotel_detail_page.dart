// room_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/theme/theme.dart';
import 'hotel_card.dart';
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

  void _showRoomDetails(BuildContext context, Room room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildRoomDetailsSheet(context, room),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Room> rooms = hotel.rooms;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            title: Text(
              hotel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.black.withOpacity(0.4),
            foregroundColor: Colors.white,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Iconsax.arrow_left, size: 20),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Iconsax.heart, size: 22),
                  onPressed: () {
                    // Add to favorites
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, size: 22),
                  onPressed: () {
                    // Share functionality
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Header Image Sliver
          SliverAppBar(
            expandedHeight: 280,
            collapsedHeight: 0,
            toolbarHeight: 0,
            pinned: false,
            floating: false,
            backgroundColor: AppColor.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildPropertyImagesCarousel(),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hotel Name and Rating - Compact
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.star1,
                                        size: 16,
                                        color: AppColor.ratingColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${hotel.starRating.toStringAsFixed(1)} Star',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.primary.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    hotel.customerRating?.toStringAsFixed(1) ?? '--',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  Text(
                                    '${hotel.reviewCount} reviews',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: AppColor.primary.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Location - Compact
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: AppColor.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              hotel.city,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.primary.withOpacity(0.7),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'From \$${hotel.startingPrice}/night',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Description Section - Compact
                        Text(
                          'About',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hotel.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.primary.withOpacity(0.7),
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 20),

                        // Amenities Section - Compact
                        Text(
                          'Amenities',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: hotel.amenities.map((amenity) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                amenity,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.primary.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Contact - Compact
                        Row(
                          children: [
                            Icon(
                              Iconsax.call,
                              color: AppColor.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              hotel.contactNumber,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Available Rooms Header
                        Text(
                          'Available Rooms (${rooms.length})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Room Cards List - Compact
                  ...rooms.map((room) => _buildCompactRoomCard(room)).toList(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyImagesCarousel() {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: hotel.imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                hotel.imageUrls[index],
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColor.primary.withOpacity(0.1),
                    child: Center(
                      child: Icon(
                        Iconsax.house,
                        size: 60,
                        color: AppColor.primary.withOpacity(0.3),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
          ),
          
          // Image Indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                hotel.imageUrls.length,
                (index) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRoomCard(Room room) {
    return GestureDetector(
      onTap: () => _showRoomDetails(Get.context!, room),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Room Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: room.images.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(room.images.first),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: AppColor.primary.withOpacity(0.1),
                ),
                child: room.images.isEmpty
                    ? Icon(
                        Iconsax.home,
                        size: 32,
                        color: AppColor.primary.withOpacity(0.3),
                      )
                    : null,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Room Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          room.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: room.isAvailable
                              ? Colors.green.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          room.isAvailable ? 'Available' : 'Booked',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: room.isAvailable ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Iconsax.people,
                        size: 14,
                        color: AppColor.primary.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Max ${room.maxGuests} guests',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.primary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${room.pricePerNight.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondary,
                        ),
                      ),
                      Text(
                        '/night',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColor.primary.withOpacity(0.5),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: AppColor.primary.withOpacity(0.4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomDetailsSheet(BuildContext context, Room room) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle Bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Room Images Carousel
                  if (room.images.isNotEmpty)
                    SizedBox(
                      height: 240,
                      child: PageView.builder(
                        itemCount: room.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            room.images[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColor.primary.withOpacity(0.1),
                                child: Icon(
                                  Iconsax.home,
                                  size: 60,
                                  color: AppColor.primary.withOpacity(0.3),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Room Name and Status
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                room.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: room.isAvailable
                                    ? Colors.green.withOpacity(0.15)
                                    : Colors.red.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    room.isAvailable
                                        ? Iconsax.tick_circle
                                        : Iconsax.close_circle,
                                    size: 14,
                                    color: room.isAvailable ? Colors.green : Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    room.isAvailable ? 'Available' : 'Booked',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: room.isAvailable ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Quick Info
                        Row(
                          children: [
                            Icon(
                              Iconsax.people,
                              size: 16,
                              color: AppColor.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Max ${room.maxGuests} guests',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.primary.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          'Description',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          room.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.primary.withOpacity(0.7),
                            height: 1.5,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Price Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price per night',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.primary.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${room.pricePerNight.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Book Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: room.isAvailable
                    ? () {
                        Get.back();
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
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                child: Text(
                  room.isAvailable ? 'Book This Room' : 'Not Available',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}