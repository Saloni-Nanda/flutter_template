import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/theme/theme.dart';
import 'package:intl/intl.dart';
import '../../common/models/hotel_search_data.dart';
import '../../utils/app_routes.dart';



class HotelSearchWidget extends StatefulWidget {
  final dynamic initialData;
  final bool showDownArrow;
  final bool showModifyButton;

  const HotelSearchWidget({
    Key? key,
    this.initialData,
    this.showDownArrow = false,
    this.showModifyButton = false,
  }) : super(key: key);

  @override
  State<HotelSearchWidget> createState() => _HotelSearchWidgetState();
}

class _HotelSearchWidgetState extends State<HotelSearchWidget> {
  bool _isLoading = false;
  String destination = '';
  DateTime checkIn = DateTime.now().add(const Duration(days: 1));
  DateTime checkOut = DateTime.now().add(const Duration(days: 2));
  bool showGuestSelector = false;
  bool isSearchCardExpanded = false;

  int rooms = 1;
  int adults = 1;
  int children = 0;
  int infants = 0;

  List<int> childAges = [];
  List<String> infantAges = [];

  int get totalGuests => adults + children + infants;
  int get remainingSlots => (4 * rooms) - totalGuests;

  @override
  void initState() {
    super.initState();

    // Initialize with initial data if provided
    if (widget.initialData != null) {
      if (widget.initialData is String) {
        destination = widget.initialData as String;
      } else if (widget.initialData is HotelSearchData) {
        destination = widget.initialData.destination;
        checkIn = widget.initialData.checkIn;
        checkOut = widget.initialData.checkOut;
        rooms = widget.initialData.rooms;
        adults = widget.initialData.adults;
        children = widget.initialData.children;
        infants = widget.initialData.infants;
        childAges = List.from(widget.initialData.childAges);
        infantAges = List.from(widget.initialData.infantAges);
      }
    }
  }


  void handleChildrenChange(int newValue) {
    if (totalGuests - children + newValue <= 4 * rooms) {
      setState(() {
        children = newValue;
        if (newValue > childAges.length) {
          childAges.addAll(List.filled(newValue - childAges.length, 5));
        } else {
          childAges = childAges.sublist(0, newValue);
        }
      });
    }
  }

  void handleInfantsChange(int newValue) {
    if (totalGuests - infants + newValue <= 4 * rooms) {
      setState(() {
        infants = newValue;
        if (newValue > infantAges.length) {
          infantAges.addAll(
            List.filled(newValue - infantAges.length, '12 months'),
          );
        } else {
          infantAges = infantAges.sublist(0, newValue);
        }
      });
    }
  }

  void handleAdultsChange(int newValue) {
    if (totalGuests - adults + newValue <= 4 * rooms && newValue >= 1) {
      setState(() {
        adults = newValue;
      });
    }
  }

  Future<void> selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime today = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? checkIn
          : (checkIn.add(const Duration(days: 1))),
      firstDate: isCheckIn
          ? today
          : checkIn.add(const Duration(days: 1)),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColor.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkIn = picked;
          if (checkOut.isBefore(checkIn) || checkOut == checkIn) {
            checkOut = checkIn.add(const Duration(days: 1));
          }
        } else {
          checkOut = picked;
        }
      });
    }
  }

  Future<void> _handleSearch(BuildContext context) async {
    // Validate destination
    if (destination.trim().isEmpty) {
      _showValidationDialog('Please enter a destination');
      return;
    }

    // Validate dates
    if (checkOut.isBefore(checkIn) || checkOut == checkIn) {
      _showValidationDialog('Check-out date must be after check-in date');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call or processing delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Create search data
    final searchData = HotelSearchData(
      destination: destination.trim(),
      checkIn: checkIn,
      checkOut: checkOut,
      rooms: rooms,
      adults: adults,
      children: children,
      infants: infants,
      childAges: childAges,
      infantAges: infantAges,
    );

    // Navigate to searched hotels page
    Get.toNamed(AppRoutes.searchedHotels, arguments: searchData);

    setState(() {
      _isLoading = false;
    });
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Error'),
        content: Text(message, style: const TextStyle(
          color: AppColor.primary,
        ),),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleCancel() {
     Get.toNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _handleCancel,
        ),
        title: const Text(
          'Search Hotels',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  
                  title: const Text('Search Help',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),),
                  content: const Text(
                    '• Each room can accommodate up to 4 guests total\n'
                    '• Children: Ages 1-12 years\n'
                    '• Infants: Under 2 years\n'
                    '• At least 1 adult per room required',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primary,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK', style: TextStyle(
                        color: AppColor.secondary
                      ),),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.primary,
                  AppColor.primary.withOpacity(0.2),
                ],
              ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // Main Card
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Destination
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColor.primary.withOpacity(0.3),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(text: destination)
                                    ..selection = TextSelection.fromPosition(
                                      TextPosition(offset: destination.length),
                                    ),
                                  onChanged: (value) => setState(() {
                                    destination = value;
                                  }),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Where to?',
                                    hintStyle: TextStyle(
                                      color: AppColor.primary.withOpacity(0.4),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              if (destination.isNotEmpty)
                                IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: AppColor.primary.withOpacity(0.3),
                                    size: 20,
                                  ),
                                  onPressed: () => setState(() {
                                    destination = '';
                                  }),
                                  splashRadius: 16,
                                ),
                            ],
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Divider(height: 1),
                        ),

                        // Check-in and Check-out
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => selectDate(context, true),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Check-In',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColor.primary.withOpacity(0.6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(checkIn),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: AppColor.primary.withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 32,
                                color: const Color(0xFFE2E8F0),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => selectDate(context, false),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Check-Out',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColor.primary.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('dd-MM-yyyy').format(checkOut),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: AppColor.primary.withOpacity(0.4),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Divider(height: 1),
                        ),

                        // Guest Summary
                        InkWell(
                          onTap: () {
                            setState(() {
                              showGuestSelector = !showGuestSelector;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Rooms ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.primary.withOpacity(0.6),
                                          ),
                                        ),
                                        TextSpan(
                                          text: '$rooms',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' • Adults ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.primary.withOpacity(0.6),
                                          ),
                                        ),
                                        TextSpan(
                                          text: '$adults',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        if (children > 0) ...[
                                          TextSpan(
                                            text: ' • Children ',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.primary.withOpacity(0.6),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '$children',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ],
                                        if (infants > 0) ...[
                                          TextSpan(
                                            text: ' • Infants ',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.primary.withOpacity(0.6),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '$infants',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  showGuestSelector
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: AppColor.primary.withOpacity(0.3),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Guest Selector
                        if (showGuestSelector)
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Who\'s Staying?',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: remainingSlots >= 0
                                            ? AppColor.secondary.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Total: $totalGuests/${4 * rooms}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: remainingSlots >= 0
                                              ? AppColor.secondary
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Rooms
                                _buildCompactCounter(
                                  'Rooms',
                                  rooms,
                                  () => setState(() {
                                    if (rooms > 1) {
                                      rooms--;
                                      // Ensure we don't exceed room capacity
                                      if (totalGuests > 4 * rooms) {
                                        // Adjust guests to fit new room capacity
                                        final excess = totalGuests - (4 * rooms);
                                        if (infants >= excess) {
                                          infants -= excess;
                                        } else {
                                          final remaining = excess - infants;
                                          infants = 0;
                                          if (children >= remaining) {
                                            children -= remaining;
                                          } else {
                                            final adultsRemaining = remaining - children;
                                            children = 0;
                                            adults = adults - adultsRemaining;
                                          }
                                        }
                                      }
                                    }
                                  }),
                                  () => setState(() {
                                    if (rooms < 5) rooms++;
                                  }),
                                ),
                                const SizedBox(height: 12),

                                // Adults
                                _buildCompactCounter(
                                  'Adults',
                                  adults,
                                  () => handleAdultsChange(adults - 1),
                                  () => handleAdultsChange(adults + 1),
                                ),
                                const SizedBox(height: 12),

                                // Children
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildCompactCounter(
                                      'Children',
                                      children,
                                      () => handleChildrenChange(children > 0 ? children - 1 : 0),
                                      () => handleChildrenChange(children + 1),
                                    ),
                                    // Child Ages Selector
                                    if (children > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Child Ages (1-12 yrs)',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.primary.withOpacity(0.6),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ...List.generate(
                                              children,
                                              (index) => Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Child ${index + 1}',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.primary.withOpacity(0.4),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    _buildAgeSlider(
                                                      selectedAge: childAges[index],
                                                      onSelect: (newAge) {
                                                        setState(() {
                                                          childAges[index] = newAge;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // Infants
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildCompactCounter(
                                      'Infants',
                                      infants,
                                      () => handleInfantsChange(infants > 0 ? infants - 1 : 0),
                                      () => handleInfantsChange(infants + 1),
                                    ),
                                    // Infant Ages Selector
                                    if (infants > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Infant Ages',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.primary.withOpacity(0.6),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ...List.generate(
                                              infants,
                                              (index) => Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Infant ${index + 1}',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.primary.withOpacity(0.4),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: _buildAgeOption(
                                                            'Under 1 year',
                                                            infantAges[index] == '12 months',
                                                            () => setState(() {
                                                              infantAges[index] = '12 months';
                                                            }),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                          child: _buildAgeOption(
                                                            '1-2 years',
                                                            infantAges[index] == '24 months',
                                                            () => setState(() {
                                                              infantAges[index] = '24 months';
                                                            }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Save Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 42,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        showGuestSelector = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.secondary,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: AppColor.secondary,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'SAVE',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        if (!showGuestSelector) const SizedBox(height: 16),

                        // Search Button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _handleSearch(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 3,
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'SEARCH',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick Suggestions
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Popular Destinations',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildQuickSuggestion('New York', Icons.apartment),
                            _buildQuickSuggestion('Paris', Icons.flag),
                            _buildQuickSuggestion('Tokyo', Icons.location_city),
                            _buildQuickSuggestion('Dubai', Icons.wb_sunny),
                            _buildQuickSuggestion('London', Icons.account_balance),
                            _buildQuickSuggestion('Bali', Icons.beach_access),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCounter(
    String title,
    int value,
    VoidCallback onDecrement,
    VoidCallback onIncrement,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            ),
          ),
          Row(
            children: [
              _buildCounterButton(Icons.remove, onDecrement, value > (title == 'Adults' ? 1 : 0)),
              Container(
                width: 36,
                alignment: Alignment.center,
                child: Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ),
              _buildCounterButton(Icons.add, onIncrement, remainingSlots > 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onTap, bool enabled) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: enabled ? AppColor.primary : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? Colors.white : Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildAgeOption(String text, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColor.primary : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColor.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildAgeSlider({
    required int selectedAge,
    required Function(int) onSelect,
    int minAge = 1,
    int maxAge = 12,
  }) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: maxAge - minAge + 1,
        itemBuilder: (context, index) {
          int age = index + minAge;
          bool isSelected = age == selectedAge;

          return GestureDetector(
            onTap: () => onSelect(age),
            child: Container(
              width: 35,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primary : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? AppColor.primary : Colors.grey.shade300,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                age.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColor.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickSuggestion(String destination, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          this.destination = destination;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: AppColor.primary,
            ),
            const SizedBox(width: 6),
            Text(
              destination,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}