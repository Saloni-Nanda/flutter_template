// filter_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppColor {
  static const Color primary = Color(0xFF0A1A3D);
  static const Color secondary = Color.fromARGB(255, 173, 129, 48);
  static const Color background = Color(0xFFF8F8F8);
  static const Color text = Color(0xFF000000);
  static const Color textLight = Color(0xFF666666);
  static const Color bottomBarBackground = Colors.white;
  static const Color bottomBarSelected = primary;
  static const Color bottomBarUnselected = Color(0xFF888888);
  static const Color bottomBarIconSelected = primary;
  static const Color bottomBarIconUnselected = Color(0xFF888888);
  static const Color cardBackground = Colors.white;
  static const Color ratingColor = Color(0xFFFFD700);
  static const Color chipBackground = Color(0xFFE8F0FE);
  static const Color cardBorder = Color(0xFFE0E0E0);
}

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Price Range
  RangeValues _priceRange = const RangeValues(50, 500);
  final double _minPrice = 0;
  final double _maxPrice = 1000;

  // Star Rating
  Set<int> _selectedStars = {};

  // Amenities
  final Map<String, bool> _amenities = {
    'WiFi': false,
    'Parking': false,
    'Pool': false,
    'Gym': false,
    'Restaurant': false,
    'Room Service': false,
    'Spa': false,
    'Pet Friendly': false,
  };

  // Property Type
  String _propertyType = 'All';
  final List<String> _propertyTypes = [
    'All',
    'Hotel',
    'Resort',
    'Villa',
    'Apartment',
    'Hostel',
  ];

  // Guest Rating
  double _guestRating = 0;

  // Meal Plans
  final Map<String, bool> _mealPlans = {
    'Room Only': false,
    'Breakfast Included': false,
    'Half Board': false,
    'Full Board': false,
    'All Inclusive': false,
  };

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(50, 500);
      _selectedStars.clear();
      _amenities.updateAll((key, value) => false);
      _propertyType = 'All';
      _guestRating = 0;
      _mealPlans.updateAll((key, value) => false);
    });
  }

  void _applyFilters() {
    // Return filter data
    Get.back(result: {
      'priceRange': _priceRange,
      'stars': _selectedStars.toList(),
      'amenities': _amenities.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
      'propertyType': _propertyType,
      'guestRating': _guestRating,
      'mealPlans': _mealPlans.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColor.primary),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: const Text(
              'Reset',
              style: TextStyle(
                color: AppColor.secondary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range Section
                  _buildSection(
                    title: 'Price Range',
                    icon: Iconsax.dollar_circle,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${_priceRange.start.toInt()}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondary,
                                ),
                              ),
                              Text(
                                '\$${_priceRange.end.toInt()}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RangeSlider(
                          values: _priceRange,
                          min: _minPrice,
                          max: _maxPrice,
                          divisions: 20,
                          activeColor: AppColor.secondary,
                          inactiveColor: AppColor.secondary.withOpacity(0.2),
                          labels: RangeLabels(
                            '\$${_priceRange.start.toInt()}',
                            '\$${_priceRange.end.toInt()}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _priceRange = values;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Star Rating Section
                  _buildSection(
                    title: 'Star Rating',
                    icon: Iconsax.star,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(5, (index) {
                          final stars = index + 1;
                          final isSelected = _selectedStars.contains(stars);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedStars.remove(stars);
                                } else {
                                  _selectedStars.add(stars);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.secondary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.secondary
                                      : AppColor.cardBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.star1,
                                    size: 18,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColor.ratingColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$stars Star',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColor.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  // Property Type Section
                  _buildSection(
                    title: 'Property Type',
                    icon: Iconsax.buildings,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _propertyTypes.map((type) {
                          final isSelected = _propertyType == type;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _propertyType = type;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.primary
                                      : AppColor.cardBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColor.primary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Guest Rating Section
                  _buildSection(
                    title: 'Guest Rating',
                    icon: Iconsax.star1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _guestRating > 0
                                    ? '${_guestRating.toStringAsFixed(1)}+'
                                    : 'Any',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondary,
                                ),
                              ),
                              if (_guestRating > 0)
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.star1,
                                      size: 20,
                                      color: AppColor.ratingColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _guestRating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Slider(
                          value: _guestRating,
                          min: 0,
                          max: 5,
                          divisions: 10,
                          activeColor: AppColor.secondary,
                          inactiveColor: AppColor.secondary.withOpacity(0.2),
                          label: _guestRating > 0
                              ? '${_guestRating.toStringAsFixed(1)}+'
                              : 'Any',
                          onChanged: (value) {
                            setState(() {
                              _guestRating = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Amenities Section
                  _buildSection(
                    title: 'Amenities',
                    icon: Iconsax.tick_circle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: _amenities.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primary,
                                  ),
                                ),
                                value: entry.value,
                                activeColor: AppColor.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _amenities[entry.key] = value ?? false;
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Meal Plans Section
                  _buildSection(
                    title: 'Meal Plans',
                    icon: Iconsax.coffee,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: _mealPlans.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primary,
                                  ),
                                ),
                                value: entry.value,
                                activeColor: AppColor.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _mealPlans[entry.key] = value ?? false;
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Apply Button
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
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: AppColor.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}