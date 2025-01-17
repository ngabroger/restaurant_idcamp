import 'dart:convert';

import 'package:find_restaurant/data/model/detail_restaurant.dart';
import 'package:find_restaurant/data/model/list_restaurant_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  final String list = 'list';
  final String detail = 'detail/';
  final String search = 'search?q=';
  final String review = 'review';

  Future<RestaurantListResponse> getListRestaurant() async {
    final response = await http.get(Uri.parse("$baseUrl/$list"));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantListResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/$search$query"));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantListResponse> postReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$review"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
    );
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}
