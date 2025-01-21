import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:find_restaurant/static/restaurant_list_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiService;

  List<Restaurant> _favoriteRestarant = [];

  List<Restaurant> get favoriteRestarant => _favoriteRestarant;

  RestaurantListProvider(this._apiService);

  RestaurantListResultState _state = RestaurantListResultStateInitial();

  RestaurantListResultState get state => _state;

  Future<void> fetchRestaurantList() async {
    try {
      _state = RestaurantListResultStateLoading();
      notifyListeners();
      final result = await _apiService.getListRestaurant();
      if (result.error) {
        _state = RestaurantListResultStateError(result.message);
        notifyListeners();
      } else {
        _state = RestaurantListResultStateData(result.restaurants);
        notifyListeners();

        _favoriteRestarant = result.restaurants
            .where(
              (element) => element.rating > 4.7,
            )
            .toList();
      }
    } on Exception catch (e) {
      _state = RestaurantListResultStateError("No Internet Connection");
      notifyListeners();
    }
  }
}
