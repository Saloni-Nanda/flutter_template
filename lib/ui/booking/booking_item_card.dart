import 'package:flutter/material.dart';
import '../../common/theme/theme.dart';
import '../searched_hotel_list/search_summary_card.dart';

enum BookingStatus { booked, pending, checkedOut, canceled }

class BookingItem {
  final String id;
  final String hotelName;
  final String city;
  final String imageUrl;
  final DateTime checkIn;
  final DateTime checkOut;
  final String roomName;
  final int adults;
  final int children;
  final int infants;
  final BookingStatus status;
  final String? cancellationReason;

  BookingItem({
    required this.id,
    required this.hotelName,
    required this.city,
    required this.imageUrl,
    required this.checkIn,
    required this.checkOut,
    required this.roomName,
    required this.adults,
    required this.children,
    required this.infants,
    required this.status,
    this.cancellationReason,
  });
}

class BookingItemCard extends StatelessWidget {
  final BookingItem booking;
  final VoidCallback? onViewRooms; // reuse if needed
  final VoidCallback? onImageTap;

  const BookingItemCard({
    Key? key,
    required this.booking,
    this.onViewRooms,
    this.onImageTap,
  }) : super(key: key);

  Color _statusColor(BookingStatus s) {
    switch (s) {
      case BookingStatus.booked:
        return AppColor.secondary;
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.checkedOut:
        return Colors.green;
      case BookingStatus.canceled:
        return Colors.red;
    }
  }

  String _statusText(BookingStatus s) {
    switch (s) {
      case BookingStatus.booked:
        return 'Booked';
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.checkedOut:
        return 'Checked-out';
      case BookingStatus.canceled:
        return 'Canceled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onImageTap,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                booking.imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: 110,
                  height: 110,
                  color: Colors.grey[200],
                  child: const Icon(Icons.hotel, size: 36, color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          booking.hotelName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(booking.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _statusText(booking.status),
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: AppColor.textLight),
                      const SizedBox(width: 6),
                      Text(
                        booking.city,
                        style: const TextStyle(color: AppColor.textLight, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_formatDate(booking.checkIn)} - ${_formatDate(booking.checkOut)}',
                    style: const TextStyle(color: AppColor.textLight, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking.roomName,
                    style: TextStyle(color: AppColor.primary.withOpacity(0.8), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}
