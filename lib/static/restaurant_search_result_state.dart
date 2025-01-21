import '../data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchResultStateInitial extends RestaurantSearchResultState {}

class RestaurantSearchResultStateLoading extends RestaurantSearchResultState {}

class RestaurantSearchResultStateData extends RestaurantSearchResultState {
  final List<Restaurant> restaurants;

  RestaurantSearchResultStateData(this.restaurants);
}

class RestaurantSearchResultStateError extends RestaurantSearchResultState {
  final String message;

  RestaurantSearchResultStateError(this.message);
}
