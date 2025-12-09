import 'package:get/get.dart';
import '../views/splash/splash_page.dart';
import '../views/home/home_page.dart';
import '../views/search/search_page.dart';
import '../views/booking/my_booking_page.dart';
import '../views/profile/profile_page.dart';
import '../ui/searched_hotel_list/searched_hotel_list_page.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const search = '/search';
  static const bookings = '/bookings';
  static const profile = '/profile';
  static const searchedHotels = '/searched_hotels';

  static final routes = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: search, page: () => const SearchPage()),
    GetPage(name: bookings, page: () => const MyBookingPage()),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: searchedHotels, page: () => const SearchedHotelListPage()),
  ];
}
