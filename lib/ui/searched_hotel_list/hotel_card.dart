import 'package:flutter/material.dart';
import '../../common/theme/theme.dart';

class Room {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final int maxGuests;
  final double pricePerNight;
  final bool isAvailable;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.maxGuests,
    required this.pricePerNight,
    required this.isAvailable,
  });
}

class Hotel {
  final String id;
  final String name;
  final String city;
  final List<String> imageUrls;
  final double starRating;
  final double? customerRating;
  final int reviewCount;
  final String description;
  final double startingPrice;
  final String contactNumber;
  final List<String> amenities;
  final List<Room> rooms;

  Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.imageUrls,
    required this.starRating,
    this.customerRating,
    required this.reviewCount,
    required this.description,
    required this.startingPrice,
    required this.contactNumber,
    required this.amenities,
    required this.rooms,
  });
}

class HotelCard extends StatefulWidget {
  final Hotel hotel;
  final VoidCallback? onViewRooms;
  final VoidCallback? onFavorite;
  final VoidCallback? onTap;

  const HotelCard({
    Key? key,
    required this.hotel,
    this.onViewRooms,
    this.onFavorite,
    this.onTap,
  }) : super(key: key);

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> with TickerProviderStateMixin {
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  PageController _pageController = PageController(viewportFraction: 1.0);
  late AnimationController _autoCarouselController;

  @override
  void initState() {
    super.initState();
    _autoCarouselController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);
    
    _startAutoCarousel();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoCarouselController.dispose();
    super.dispose();
  }

  void _startAutoCarousel() {
    _autoCarouselController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextImage();
        _autoCarouselController.reset();
        _autoCarouselController.forward();
      }
    });
    _autoCarouselController.forward();
  }

  void _nextImage() {
    if (widget.hotel.imageUrls.length > 1) {
      final nextIndex = (_currentImageIndex + 1) % widget.hotel.imageUrls.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel Section
            _buildImageCarousel(),

            // Hotel Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Original Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.hotel.startingPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  
                  const SizedBox(height: 2),
                  
                  Text(
                    'Starting from per night',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.textLight,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Hotel Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.hotel.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Rating Badge
                      if (widget.hotel.customerRating != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.hotel.customerRating}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // City Name
                  Row(
                    children: [
                     const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColor.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.hotel.city,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.textLight,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Star Rating (Hotel Classification)
                  _buildStarRating(),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    widget.hotel.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.textLight,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  // Reviews Count and Book Now Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Review Count
                      Row(
                        children: [
                          Text(
                            widget.hotel.reviewCount > 0
                                ? '${widget.hotel.reviewCount} reviews'
                                : 'No reviews yet',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColor.textLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          
                        ],
                      ),
                      // Book Now Button
                      ElevatedButton(
                        onPressed: widget.onViewRooms,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.secondary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'BOOK NOW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
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
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        // Main Image Container
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.hotel.imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
                _autoCarouselController.reset();
                _autoCarouselController.forward();
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _autoCarouselController.reset();
                    _autoCarouselController.forward();
                  },
                  child: Image.network(
                    widget.hotel.imageUrls[index],
                    width: double.infinity,
                    height: 200,
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
                            color: AppColor.secondary,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.hotel,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),

        

        // Dot Navigation Indicators
        if (widget.hotel.imageUrls.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.hotel.imageUrls.length,
                (index) => GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      _currentImageIndex = index;
                    });
                    _autoCarouselController.reset();
                    _autoCarouselController.forward();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentImageIndex == index ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: _currentImageIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),

        // Wishlist Button Badge
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              widget.onFavorite?.call();
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.9),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : AppColor.textLight,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    final fullStars = widget.hotel.starRating.floor();
    final hasHalfStar = widget.hotel.starRating - fullStars >= 0.5;
    
    return Row(
      children: [
        // Full Stars
        ...List.generate(fullStars, (index) => const Icon(
          Icons.star,
          size: 16,
          color: AppColor.ratingColor,
        )),
        
        // Half Star if needed
        if (hasHalfStar)
          const Icon(
            Icons.star_half,
            size: 16,
            color: AppColor.ratingColor,
          ),
        
        // Empty Stars
        ...List.generate(
          5 - fullStars - (hasHalfStar ? 1 : 0),
          (index) => Icon(
            Icons.star_border,
            size: 16,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}