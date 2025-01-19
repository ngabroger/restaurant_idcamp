import 'package:find_restaurant/controllers/restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();
    final RestaurantController controller = Get.find<RestaurantController>();
    if (controller.detailRestaurant.value?.id != widget.restaurantId) {
      controller.fetchRestaurantDetail(widget.restaurantId);
    }
    return Scaffold(
        body: Obx(
          () {
            if (controller.isDetailLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.isError.value) {
              return Center(
                child: Text(controller.errorMessage.value),
              );
            } else {
              final restaurant = controller.detailRestaurant.value;
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          ),
                          Positioned(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleButton(
                                  iconImage: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.grey[600],
                                  ),
                                  onTap: () => Get.back(),
                                ),
                                CircleButton(
                                  iconImage: Icon(
                                    isFavorite
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                    color: Colors.grey[700],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            restaurant.categories
                                                .map(
                                                    (category) => category.name)
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 4),
                                            Text(review.review),
                                            SizedBox(height: 4),
                                            Text(
                                              review.date,
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                            controller.addReview(widget.restaurantId,
                                nameController.text, reviewController.text);
                            Navigator.pop(context);
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
