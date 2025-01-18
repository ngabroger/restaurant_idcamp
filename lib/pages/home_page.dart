import 'package:find_restaurant/controllers/recent_restaurant_controller.dart';
import 'package:find_restaurant/controllers/restaurant_controller.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/routes/navigation_routes.dart';
import 'package:find_restaurant/widget/recent_card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantController controller =
        Get.put(RestaurantController(apiService: ApiService()));
    final RecentRestaurantController recentController =
        Get.put(RecentRestaurantController());
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        spacing: 12.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            spacing: 8.0,
            children: [
              Icon(
                Icons.restaurant_menu_outlined,
                color: Colors.deepOrangeAccent,
              ),
              Text(
                "Find Restaurant",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "https://i.pinimg.com/736x/45/9e/3c/459e3c1b8558cb55361c8819deddac07.jpg",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back,"),
                  Text(
                    "Ambalabu",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Center(
            child: Dash(
              length: MediaQuery.of(context).size.width * 0.9,
              dashLength: 10,
              dashColor: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 12.0,
            ),
            child: Obx(() {
              final recent = recentController.recentRestaurants.value;
              return Text(
                recent == null ? "" : "Recent Restaurant",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              );
            }),
          ),
          Center(
            child: Obx(
              () {
                final recent = recentController.recentRestaurants.value;

                if (recent == null) {
                  return Center(
                    child: Text("NO Recent Data Found"),
                  );
                } else {
                  return RecentCard(
                      onTap: () {
                        Get.toNamed(NavigationRoutes.detailRoute.name,
                            parameters: {'id': recent.id});
                      },
                      recents: recent);
                }
              },
            ),
          ),
          Text(
            "Favorites Restaurant",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Obx(
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
                var favoriteRestaurant = controller.restaurantList
                    .where((element) => element.rating > 4.7)
                    .toList();
                return SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: favoriteRestaurant.length,
                    itemBuilder: (context, index) {
                      var restaurant = favoriteRestaurant[index];
                      return GestureDetector(
                          onTap: () {
                            recentController.addRecentRestaurant(restaurant);
                            Get.toNamed(NavigationRoutes.detailRoute.name,
                                parameters: {'id': restaurant.id});
                          },
                          child: Container(
                            width: 200,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                                      width: double.infinity,
                                      height: 104,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              restaurant.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  restaurant.rating.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          restaurant.city,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
