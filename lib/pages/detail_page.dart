import 'package:find_restaurant/controllers/favorite_controller/favorite_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_detail_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_review_provider.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/static/restaurant_detail_result_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../widget/circle_button.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => context
        .read<RestaurantDetailProvider>()
        .fetchDetailRestaurant(widget.restaurantId));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();
    final RestaurantDetailProvider detailController =
        context.read<RestaurantDetailProvider>();
    final RestaurantReviewProvider controller =
        context.read<RestaurantReviewProvider>();
    return Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, value, child) {
            switch (value.state) {
              case RestaurantDetailResultStateLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );
              case RestaurantDetailResultStateError(message: var message):
                return Center(
                  child: Text(message),
                );
              case RestaurantDetailResultStateData(restaurant: var restaurant):
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Hero(
                              tag: restaurant.pictureId,
                              child: Image.network(
                                  ApiService.images + restaurant.pictureId),
                            ),
                            Positioned(
                                child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleButton(
                                    iconImage: Icon(
                                      Icons.arrow_back_outlined,
                                      color: Colors.grey[600],
                                    ),
                                    onTap: () => Navigator.pop(context),
                                  ),
                                  Consumer<FavoriteProvider>(
                                    builder: (context, value, child) {
                                      isFavorite = value.isFavorite;
                                      return CircleButton(
                                        iconImage: Icon(
                                          isFavorite
                                              ? Icons.favorite_border
                                              : Icons.favorite,
                                          color: Colors.grey[700],
                                        ),
                                        onTap: () {
                                          value.setFavorite(!isFavorite);
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.only(top: 200),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      restaurant.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[700],
                                      ),
                                      Text(
                                        restaurant.rating.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              ReadMoreText(
                                restaurant.description,
                                trimLines: 2,
                                colorClickableText: Colors.blue,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "... Read More",
                                trimExpandedText: " Show Less",
                                style: TextStyle(fontSize: 14),
                              ),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Location",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${restaurant.city}, ${restaurant.address}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 12),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.category_rounded,
                                                  size: 20,
                                                  color: Colors.green[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Categories",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              restaurant.categories
                                                  .map((category) =>
                                                      category.name)
                                                  .join(", "),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Our Menus",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Foods",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 2,
                                      children: restaurant.menus.foods
                                          .map((food) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Chip(
                                                  label: Text(food.name),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Drinks",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 2,
                                      children: restaurant.menus.drinks
                                          .map((drinks) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Chip(
                                                  label: Text(drinks.name),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Reviews",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: restaurant.customerReviews.length,
                                  itemBuilder: (context, index) {
                                    final review =
                                        restaurant.customerReviews[index];
                                    return Container(
                                      padding: EdgeInsets.all(8.0),
                                      width: 200,
                                      child: Card(
                                        elevation: 4,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  review.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Expanded(
                                                child: Text(review.review,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                review.date,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
        floatingActionButton: CircleButton(
          iconImage: Icon(Icons.add),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Review",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      TextField(
                        controller: reviewController,
                        decoration: InputDecoration(
                          labelText: "Review",
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty ||
                                reviewController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Name and review cannot be empty!')),
                              );
                              return;
                            }
                            controller
                                .addReview(widget.restaurantId,
                                    nameController.text, reviewController.text)
                                .then((_) {
                              detailController
                                  .fetchDetailRestaurant(widget.restaurantId);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Review successfully added!')),
                              );
                            }).catchError((error) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Failed to add review: $error')),
                              );
                            });
                          },
                          child: Text("Submit"))
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
