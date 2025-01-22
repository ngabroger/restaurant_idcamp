import 'package:find_restaurant/data/model/detail_restaurant.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/favorite_controller/favorite_provider.dart';
import '../../controllers/favorite_controller/local_database_provider.dart';
import '../../widget/circle_button.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    final favoriteProvider = context.read<FavoriteProvider>();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();

    Future.microtask(
      () async {
        await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);
        final value = localDatabaseProvider.restaurant == null
            ? false
            : localDatabaseProvider.restaurant!.id == widget.restaurant.id;
        favoriteProvider.setFavorite(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      iconImage: Icon(
        context.watch<FavoriteProvider>().isFavorite
            ? Icons.favorite
            : Icons.favorite_border,
        color: Colors.grey[700],
      ),
      onTap: () async {
        final favoriteProvider = context.read<FavoriteProvider>();
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final isFavorite = favoriteProvider.isFavorite;

        if (isFavorite) {
          await localDatabaseProvider.removeFavorite(widget.restaurant.id);
        } else {
          await localDatabaseProvider.addFavorite(widget.restaurant);
        }

        await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);
        final value = localDatabaseProvider.restaurant == null
            ? false
            : localDatabaseProvider.restaurant!.id == widget.restaurant.id;
        favoriteProvider.setFavorite(value);
      },
    );
  }
}
