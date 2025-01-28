import 'package:find_restaurant/controllers/restaurant_controller/restaurant_list_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_recent_provider.dart';
import 'package:find_restaurant/static/navigation_routes.dart';
import 'package:find_restaurant/static/restaurant_list_result_state.dart';
import 'package:find_restaurant/widget/recent_card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widget/favorite_card.dart';
import '../widget/grid_restaurant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantRecent = context.read<RestaurantRecentProvider>();
    final restaurantList = context.read<RestaurantListProvider>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<RestaurantListProvider>().fetchRestaurantList();
        },
        child: ListView(
          scrollDirection: Axis.vertical,
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
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
            SizedBox(
              height: 12.0,
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
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back,",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "Ambalabu",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Dash(
                  length: MediaQuery.of(context).size.width * 0.9,
                  dashLength: 10,
                  dashColor: Colors.grey,
                ),
              ),
            ),
            Consumer<RestaurantRecentProvider>(
              builder: (context, value, child) {
                final recent = value.recentRestaurant;
                if (recent == null) {
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Stack(
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Lottie.asset('assets/food-drink.json',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: Text(
                                    "Hello Restaurant!",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                } else {
                  return Column(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Restaurant",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Center(
                        child: RecentCard(
                          onTap: () => Navigator.pushNamed(
                              context, NavigationRoutes.detailRoute.name,
                              arguments: recent.id),
                          recents: recent,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Favorites Restaurant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                switch (value.state) {
                  case RestaurantListResultStateLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case RestaurantListResultStateData():
                    return SizedBox(
                      width: double.infinity,
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurantList.favoriteRestarant.length,
                        itemBuilder: (context, index) {
                          var restaurant =
                              restaurantList.favoriteRestarant[index];
                          return FavoriteCard(
                              onTap: () {
                                restaurantRecent.addRecent(restaurant);
                                Navigator.pushNamed(
                                  context,
                                  NavigationRoutes.detailRoute.name,
                                  arguments: restaurant.id,
                                );
                              },
                              restaurant: restaurant);
                        },
                      ),
                    );
                  case RestaurantListResultStateError(error: var message):
                    return Center(
                      child: Text(message),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "List Restaurant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                switch (value.state) {
                  case RestaurantListResultStateLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case RestaurantListResultStateData(restaurants: var data):
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var restaurant = data[index];
                        return GridRestaurant(
                          restaurant: restaurant,
                          onTap: () {
                            restaurantRecent.addRecent(restaurant);
                            Navigator.pushNamed(
                              context,
                              NavigationRoutes.detailRoute.name,
                              arguments: restaurant.id,
                            );
                          },
                        );
                      },
                    );
                  case RestaurantListResultStateError(error: var message):
                    return Center(
                      child: Text(message),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
