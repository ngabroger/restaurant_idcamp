import 'package:find_restaurant/controllers/restaurant_recent.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:flutter/material.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantReviewProvider(this._apiService);

  String _message = '';
  String get message => _message;

  Future<void> addReview(String id, String name, String review) async {
    try {
      final result = await _apiService.postReview(id, name, review);
      if (result.error) {
        _message = result.message;
        notifyListeners();
      } else {
        _message = "Send Review Success";
        notifyListeners();
      }
    } catch (e) {
      _message = e.toString();
      notifyListeners();
    }
  }
}
