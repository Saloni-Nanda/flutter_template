import 'package:flutter/material.dart';
import '../../common/theme/theme.dart';
import 'package:intl/intl.dart';
import '../../common/models/hotel_search_data.dart';
import 'package:get/get.dart';
import '../../utils/app_routes.dart';

class SearchSummaryCard extends StatefulWidget {
  final HotelSearchData searchData;
  final bool showDownArrow;
  final bool showModifyButton;

  const SearchSummaryCard({
    Key? key,
    required this.searchData,
    this.showDownArrow = false,
    this.showModifyButton = true,
  }) : super(key: key);

  @override
  State<SearchSummaryCard> createState() => _SearchSummaryCardState();
}

class _SearchSummaryCardState extends State<SearchSummaryCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primary, AppColor.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
          // Destination with optional down arrow
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.searchData.destination,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (widget.showDownArrow)
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                ),
            ],
          ),

          if (isExpanded) ...[
            const SizedBox(height: 12),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 12),

            // Dates and Guest Info
            Row(
            children: [
              // Check-in/out dates
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                          color: Colors.white70, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          'Check-in',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM dd, yyyy').format(widget.searchData.checkIn),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 40,
                color: Colors.white24,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                            color: Colors.white70, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'Check-out',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM dd, yyyy').format(widget.searchData.checkOut),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Guest Summary
          Row(
            children: [
              const Icon(Icons.people, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.searchData.guestSummary,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Show child and infant ages if present
          if (widget.searchData.children > 0 || widget.searchData.infants > 0) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.searchData.children > 0) ...[
                    Text(
                      'Children ages: ${widget.searchData.childAges.join(", ")} years',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                  if (widget.searchData.infants > 0) ...[
                    if (widget.searchData.children > 0) const SizedBox(height: 4),
                    Text(
                      'Infants: ${widget.searchData.infantAges.map((age) => age == "12 months" ? "Under 1 year" : "1-2 years").join(", ")}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          ], // End of expanded content

          // Collapsed state - show modify button if enabled
          if (!isExpanded && widget.showModifyButton) ...[
            const SizedBox(height: 8),
          ],

          // Modify Search button (always visible at bottom when showModifyButton is true)
          if (widget.showModifyButton)
            Padding(
              padding: EdgeInsets.only(top: isExpanded ? 12 : 0),
              child: SizedBox(
                width: double.infinity,
                height: 36,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to search page with current data
                    Get.toNamed(
                      AppRoutes.search,
                      arguments: widget.searchData,
                    );
                  },
                  icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                  label: const Text(
                    'Modify Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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