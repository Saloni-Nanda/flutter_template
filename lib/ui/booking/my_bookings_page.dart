import 'package:flutter/material.dart';
import '../../common/theme/theme.dart';
import 'booking_item_card.dart';
import 'package:intl/intl.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<BookingItem> _mockBookings = [
    BookingItem(
      id: 'b1',
      hotelName: 'The Grand Harbor',
      city: 'New York',
      imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=60',
      checkIn: DateTime.now().add(const Duration(days: 2)),
      checkOut: DateTime.now().add(const Duration(days: 5)),
      roomName: 'Deluxe King',
      adults: 2,
      children: 1,
      infants: 0,
      status: BookingStatus.booked,
    ),
    BookingItem(
      id: 'b2',
      hotelName: 'Oceanview Resort',
      city: 'Miami',
      imageUrl: 'https://images.unsplash.com/photo-1501117716987-c8e2f5f3f2b1?auto=format&fit=crop&w=800&q=60',
      checkIn: DateTime.now().subtract(const Duration(days: 10)),
      checkOut: DateTime.now().subtract(const Duration(days: 7)),
      roomName: 'Sea Suite',
      adults: 2,
      children: 0,
      infants: 0,
      status: BookingStatus.checkedOut,
    ),
    BookingItem(
      id: 'b3',
      hotelName: 'Citylight Hotel',
      city: 'Chicago',
      imageUrl: 'https://images.unsplash.com/photo-1568495248636-643ea27d22f7?auto=format&fit=crop&w=800&q=60',
      checkIn: DateTime.now().add(const Duration(days: 12)),
      checkOut: DateTime.now().add(const Duration(days: 14)),
      roomName: 'Standard Double',
      adults: 1,
      children: 0,
      infants: 0,
      status: BookingStatus.pending,
    ),
    BookingItem(
      id: 'b4',
      hotelName: 'Mountain Escape',
      city: 'Aspen',
      imageUrl: 'https://images.unsplash.com/photo-1501117716987-c8e2f5f3f2b1?auto=format&fit=crop&w=800&q=60',
      checkIn: DateTime.now().add(const Duration(days: 5)),
      checkOut: DateTime.now().add(const Duration(days: 8)),
      roomName: 'Cabin Suite',
      adults: 4,
      children: 0,
      infants: 0,
      status: BookingStatus.canceled,
      cancellationReason: 'Guest requested full refund due to change in plans',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<BookingItem> _filter(BookingStatus? status) {
    if (status == null) return _mockBookings;
    return _mockBookings.where((b) => b.status == status).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Booked'),
            Tab(text: 'Pending'),
            Tab(text: 'Checked-out'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(null),
          _buildList(BookingStatus.booked),
          _buildList(BookingStatus.pending),
          _buildList(BookingStatus.checkedOut),
          _buildList(BookingStatus.canceled),
        ],
      ),
    );
  }

  Widget _buildList(BookingStatus? status) {
    final items = status == null ? _mockBookings : _mockBookings.where((b) => b.status == status).toList();
    if (items.isEmpty) {
      return const Center(child: Text('No bookings yet'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final b = items[index];
        return BookingItemCard(
          booking: b,
        );
      },
    );
  }
}
