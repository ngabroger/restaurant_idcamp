import '../data/model/restaurant.dart';

sealed class RestaurantListResultState {}

class RestaurantListResultStateInitial extends RestaurantListResultState {}

class RestaurantListResultStateLoading extends RestaurantListResultState {}

class RestaurantListResultStateData extends RestaurantListResultState {
  final List<Restaurant> restaurants;

  RestaurantListResultStateData(this.restaurants);
}

class RestaurantListResultStateError extends RestaurantListResultState {
  final String error;

  RestaurantListResultStateError(this.error);
}
