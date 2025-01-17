import 'package:find_restaurant/controllers/restaurant_controller.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RestaurantController controller =
      Get.put(RestaurantController(apiService: ApiService()));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.fetchRestaurantList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (controller.isError.value) {
                return Center(
                  child: Text(controller.errorMessage.value),
                );
              } else {
                return Obx(
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
            default:
              return Center(
                child: Text('Error'),
              );
          }
        });
  }
}
