import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/static/restaurant_detail_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  RestaurantDetailProvider(this._apiService);

  RestaurantDetailResultState _state = RestaurantDetailResultStateInitial();

  RestaurantDetailResultState get state => _state;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _state = RestaurantDetailResultStateLoading();
      notifyListeners();
      final result = await _apiService.getDetailRestaurant(id);
      if (result.error) {
        _state = RestaurantDetailResultStateError(result.message);
        notifyListeners();
      } else {
        _state = RestaurantDetailResultStateData(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _state = RestaurantDetailResultStateError(e.toString());
      notifyListeners();
    }
  }
}
