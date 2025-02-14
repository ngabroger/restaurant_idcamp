import 'package:find_restaurant/data/local/local_database_service.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = '';
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> addFavorite(Restaurant restaurant) async {
    try {
      final result = await _service.insertRestaurant(restaurant);

      final isError = result == 0;
      if (isError) {
        _message = 'Failed to add favorite';
      } else {
        _message = 'Success to add favorite';
        await loadAllFavorite();
      }
    } catch (_) {
      _message = 'Failed to add favorite';
    }
    notifyListeners();
  }

  Future<void> loadAllFavorite() async {
    try {
      final result = await _service.getRestaurants();
      _restaurantList = result;
      _restaurant = null;
      _message = "All of your data is Loaded";
      notifyListeners();
    } catch (_) {
      _message = "Failed to load data";
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      final result = await _service.getRestaurantById(id);
      _restaurant = result;
      _message = "Your data is Loaded";
      notifyListeners();
    } catch (_) {
      _message = "Failed to load data";

      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.deleteRestaurant(id);
      _message = "Success to remove favorite";
      await loadAllFavorite();
      notifyListeners();
    } catch (_) {
      _message = "Failed to remove favorite";
      await loadAllFavorite();
      notifyListeners();
    }
    notifyListeners();
  }

  bool checkRestaurantFavorite(String id) {
    final isSameRestaurant = _restaurant!.id == id;
    return isSameRestaurant;
  }
}
