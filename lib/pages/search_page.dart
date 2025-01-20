import 'package:find_restaurant/controllers/restaurant_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/restaurant_recent.dart';
import '../static/navigation_routes.dart';
import '../static/restaurant_search_result_state.dart';
import '../widget/search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantSearchProvider>().fetchSearchRestaurant("");
    });
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchRestaurant = context.read<RestaurantSearchProvider>();
    final restaurantRecent = context.read<RestaurantRecentProvider>();
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
                    searchRestaurant
                        .fetchSearchRestaurant(searchController.text);
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: Consumer<RestaurantSearchProvider>(
                builder: (context, value, child) {
              switch (value.state) {
                case RestaurantSearchResultStateError(message: var message):
                  return Center(
                    child: Text(message),
                  );
                case RestaurantSearchResultStateLoading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case RestaurantSearchResultStateData(
                    restaurants: var restaurants
                  ):
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = restaurants[index];
                      return SearchCard(
                        onTap: () {
                          restaurantRecent.addRecent(restaurant);
                          Navigator.pushNamed(
                              context, NavigationRoutes.detailRoute.name,
                              arguments: restaurant.id);
                        },
                        restaurant: restaurant,
                      );
                    },
                  );
                default:
                  return const SizedBox();
              }
            }))
          ],
        ),
      ),
    );
  }
}
