import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:get/get.dart';

class RecentRestaurantController extends GetxController {
  var recentRestaurants = Rxn<Restaurant>();

  void addRecentRestaurant(Restaurant restaurant) {
    recentRestaurants.value = restaurant;
  }
}
