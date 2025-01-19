import 'package:find_restaurant/controllers/restaurant_controller.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/navigation_routes.dart';
import '../widget/search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RestaurantController controller = Get.find<RestaurantController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.searchRestaurant('');
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.searchRestaurant(searchController.text);
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: Obx(
              () {
                if (controller.isSearchLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.searchResult.isEmpty) {
                  return Center(
                    child: Text('No data'),
                  );
                } else if (controller.isError.value) {
                  return Center(
                    child: Text(controller.errorMessage.value),
                  );
                } else {
                  return ListView.builder(
                      itemCount: controller.searchResult.length,
                      itemBuilder: (context, index) {
                        var restaurant = controller.searchResult[index];
                        return SearchCard(
                            onTap: () {
                              print(restaurant.id);
                              Get.toNamed(NavigationRoutes.detailRoute.name,
                                  parameters: {
                                    'id': restaurant.id,
                                  });
                            },
                            restaurant: restaurant);
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
