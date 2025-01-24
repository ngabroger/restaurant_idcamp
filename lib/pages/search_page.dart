import 'package:find_restaurant/controllers/restaurant_controller/restaurant_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/restaurant_controller/restaurant_recent_provider.dart';
import '../static/navigation_routes.dart';
import '../static/restaurant_search_result_state.dart';
import '../widget/search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantSearchProvider>().fetchSearchRestaurant("");
      }
    });
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchRestaurant = context.read<RestaurantSearchProvider>();
    final restaurantRecent = context.read<RestaurantRecentProvider>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await searchRestaurant.fetchSearchRestaurant(searchController.text);
        },
        child: Padding(
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
                  case RestaurantSearchResultStateLoading _:
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
      ),
    );
  }
}
