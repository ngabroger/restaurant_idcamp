import 'package:flutter/material.dart';

import '../controllers/recent_restaurant_controller.dart';
import '../data/model/restaurant.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.recentController,
    required this.restaurant,
    required this.onTap,
  });

  final RecentRestaurantController recentController;
  final Restaurant restaurant;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.w600),
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
  }
}
