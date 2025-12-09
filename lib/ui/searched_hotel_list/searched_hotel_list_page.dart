import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/theme/theme.dart';
import '../../common/models/hotel_search_data.dart';
import 'search_summary_card.dart';
import 'hotel_list.dart';
import 'hotel_detail_page.dart';

class SearchedHotelListPage extends StatelessWidget {
  const SearchedHotelListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get search data passed from SearchPage
    final HotelSearchData? searchData = Get.arguments as HotelSearchData?;
    if (searchData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No search data provided'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          searchData.destination,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              Get.toNamed('/filter');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Summary Card
          SearchSummaryCard(searchData: searchData, showDownArrow: true),

          // Hotel List
          Expanded(
            child: HotelList(
              onHotelTap: (hotel) {
                Get.to(() => HotelDetailPage(hotel: hotel, searchData: searchData));
              },
            ),
          ),
        ],
      ),
    );
  }

}