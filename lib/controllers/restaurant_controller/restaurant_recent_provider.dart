import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantRecentProvider extends ChangeNotifier {
  Restaurant? _recentRestaurant;
  Restaurant? get recentRestaurant => _recentRestaurant;

  void addRecent(Restaurant restaurant) {
    _recentRestaurant = restaurant;
    notifyListeners();
  }
}
