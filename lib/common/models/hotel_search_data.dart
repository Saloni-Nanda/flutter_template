import 'package:intl/intl.dart';

class HotelSearchData {
  final String destination;
  final DateTime checkIn;
  final DateTime checkOut;
  final int rooms;
  final int adults;
  final int children;
  final int infants;
  final List<int> childAges;
  final List<String> infantAges;

  const HotelSearchData({
    required this.destination,
    required this.checkIn,
    required this.checkOut,
    required this.rooms,
    required this.adults,
    required this.children,
    required this.infants,
    required this.childAges,
    required this.infantAges,
  });

  String get guestSummary {
    List<String> parts = ['$rooms ${rooms > 1 ? 'rooms' : 'room'}'];
    parts.add('$adults ${adults > 1 ? 'adults' : 'adult'}');
    if (children > 0) parts.add('$children children');
    if (infants > 0) parts.add('$infants ${infants > 1 ? 'infants' : 'infant'}');
    return parts.join(' • ');
  }

  String get dateRange {
    return '${DateFormat('MMM dd').format(checkIn)} - ${DateFormat('MMM dd').format(checkOut)}';
  }

  bool get isEmpty => destination.isEmpty;
}