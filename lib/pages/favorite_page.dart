import 'package:find_restaurant/controllers/favorite_controller/local_database_provider.dart';
import 'package:find_restaurant/static/navigation_routes.dart';
import 'package:find_restaurant/widget/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => context.read<LocalDatabaseProvider>().loadAllFavorite());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Favorite',
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: Dash(
                length: MediaQuery.of(context).size.width * 0.9,
                dashLength: 10,
                dashColor: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Consumer<LocalDatabaseProvider>(
            builder: (context, value, child) {
              final favoriteList = value.restaurantList ?? [];

              if (favoriteList.isEmpty) {
                return Center(
                  child: Text('No favorite restaurant'),
                );
              }
              return ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    final restaurant = favoriteList[index];
                    return SearchCard(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NavigationRoutes.detailRoute.name,
                              arguments: restaurant.id);
                        },
                        restaurant: restaurant);
                  });
            },
          ))
        ],
      ),
    );
  }
}
