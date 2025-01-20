import 'package:find_restaurant/static/restaurant_search_result_state.dart';
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantSearchProvider(this._apiService);

  RestaurantSearchResultState _state = RestaurantSearchResultStateInitial();
  RestaurantSearchResultState get state => _state;

  Future<void> fetchSearchRestaurant(String query) async {
    try {
      _state = RestaurantSearchResultStateLoading();
      notifyListeners();
      final result = await _apiService.searchRestaurant(query);
      if (result.error) {
        _state = RestaurantSearchResultStateError("No result found");
      } else if (result.restaurants.isEmpty) {
        _state = RestaurantSearchResultStateError("No result found");
      } else {
        _state = RestaurantSearchResultStateData(result.restaurants);
      }
    } on Exception catch (e) {
      _state = RestaurantSearchResultStateError("No Internet Connection");
    } finally {
      notifyListeners();
    }
  }
}
