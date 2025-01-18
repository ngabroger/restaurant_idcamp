import 'restaurant.dart';

class SearchListResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchListResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchListResponse.fromJson(Map<String, dynamic> json) =>
      SearchListResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
