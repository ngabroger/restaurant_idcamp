import 'package:find_restaurant/controllers/restaurant_controller.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final String restaurantId;
  const DetailPage({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    final RestaurantController controller = Get.find<RestaurantController>();
    controller.fetchRestaurantDetail(restaurantId);
    return Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Detail'),
        ),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.isError.value) {
              return Center(
                child: Text(controller.errorMessage.value),
              );
            } else {
              final restaurant = controller.detailRestaurant.value;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 8.0,
                  children: [
                    Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    ),
                    Text(restaurant.name),
                    Text(restaurant.city),
                    Text(restaurant.address),
                    Text(restaurant.description),
                    Text('Rating: ${restaurant.rating}'),
                    Wrap(
                      spacing: 8.0,
                      children: restaurant.categories
                          .map((category) => Chip(label: Text(category.name)))
                          .toList(),
                    ),
                    ...restaurant.menus.foods.map((food) => ListTile(
                          title: Text(food.name),
                        )),
                    ...restaurant.menus.drinks.map((drink) => ListTile(
                          title: Text(drink.name),
                        )),
                    ...restaurant.customerReviews.map((review) => ListTile(
                          title: Text(review.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(review.review),
                              Text(review.date),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            }
          },
        ));
  }
}
