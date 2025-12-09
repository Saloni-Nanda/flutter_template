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