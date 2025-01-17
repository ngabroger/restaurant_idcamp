import 'package:find_restaurant/controllers/restaurant_controller.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantController controller =
        Get.put(RestaurantController(apiService: ApiService()));

    return Obx(
      () {
        if (controller.isListLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.isError.value) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        } else {
          return ListView.builder(
            itemCount: controller.restaurantList.length,
            itemBuilder: (context, index) {
              var restaurant = controller.restaurantList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(NavigationRoutes.detailRoute.name,
                      parameters: {'id': restaurant.id});
                },
                child: ListTile(
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.city),
                ),
              );
            },
          );
        }
      },
    );
  }
}
