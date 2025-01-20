import 'package:find_restaurant/data/model/detail_restaurant.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailResultStateInitial extends RestaurantDetailResultState {}

class RestaurantDetailResultStateLoading extends RestaurantDetailResultState {}

class RestaurantDetailResultStateData extends RestaurantDetailResultState {
  final DetailRestaurant restaurant;

  RestaurantDetailResultStateData(this.restaurant);
}


class RestaurantDetailResultStateError extends RestaurantDetailResultState {
  final String message;

  RestaurantDetailResultStateError(this.message);
}


