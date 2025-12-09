import 'package:flutter/material.dart';
import '../../common/theme/theme.dart';

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
    
    // Start auto carousel
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 6),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name and Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.hotel.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            // City Name
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: AppColor.primary.withOpacity(0.7),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    widget.hotel.city,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.primary.withOpacity(0.8),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Star Rating with decimal support
                            _buildStarRating(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Price Tag (Lowest Price)
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
                              '\$${widget.hotel.startingPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColor.secondary,
                              ),
                            ),
                            Text(
                              'Starting from',
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

                  // Description
                  Text(
                    widget.hotel.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primary.withOpacity(0.7),
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 20),

                  // Rating and Reviews Section
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[200]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Customer Rating
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              widget.hotel.customerRating != null
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColor.ratingColor,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${widget.hotel.customerRating}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'No Rating',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary.withOpacity(0.6),
                                      ),
                                    ),
                              Text(
                                'Customer Rating',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.primary.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Reviews
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.hotel.reviewCount > 0
                                    ? '${widget.hotel.reviewCount} reviews'
                                    : 'No reviews',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primary,
                                ),
                              ),
                              Text(
                                widget.hotel.reviewCount > 0
                                    ? 'Based on customer feedback'
                                    : 'Be the first to review',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.primary.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // View Rooms Button (Full Width)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: widget.onViewRooms,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      icon: const Icon(
                        Icons.king_bed,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: const Text(
                        'View Rooms',
                        style: TextStyle(
                          color: Colors.white,
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
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        // Main Image Container
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
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
                    // Reset auto carousel on manual swipe/tap
                    _autoCarouselController.reset();
                    _autoCarouselController.forward();
                  },
                  child: Image.network(
                    widget.hotel.imageUrls[index],
                    width: double.infinity,
                    height: 220,
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

        // Gradient Overlay
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Dot Navigation Indicators
        if (widget.hotel.imageUrls.length > 1)
          Positioned(
            bottom: 16,
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
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentImageIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentImageIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      boxShadow: [
                        if (_currentImageIndex == index)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        // Wishlist Button Badge on Image
        Positioned(
          top: 16,
          right: 16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              widget.onFavorite?.call();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                  size: 22,
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
        ...List.generate(fullStars, (index) => Icon(
          Icons.star,
          size: 18,
          color: AppColor.ratingColor,
        )),
        
        // Half Star if needed
        if (hasHalfStar)
          Icon(
            Icons.star_half,
            size: 18,
            color: AppColor.ratingColor,
          ),
        
        // Empty Stars
        ...List.generate(
          5 - fullStars - (hasHalfStar ? 1 : 0),
          (index) => Icon(
            Icons.star_border,
            size: 18,
            color: Colors.grey[300],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Rating Number
        Text(
          '${widget.hotel.starRating}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.primary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}