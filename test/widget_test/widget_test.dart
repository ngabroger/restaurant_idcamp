import 'package:find_restaurant/controllers/favorite_controller/favorite_provider.dart';
import 'package:find_restaurant/controllers/favorite_controller/local_database_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_detail_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_review_provider.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/local/local_database_service.dart';
import 'package:find_restaurant/data/model/detail_restaurant.dart';
import 'package:find_restaurant/pages/detail_page.dart';
import 'package:find_restaurant/static/restaurant_detail_result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([ApiService, RestaurantDetailProvider])
void main() {
  setUpAll(() {
    provideDummy<RestaurantDetailResultState>(
      RestaurantDetailResultStateData(
        DetailRestaurant(
          id: 'dummy_id',
          name: 'dummy_name',
          description: 'dummy_description',
          pictureId: 'dummy_pictureId',
          city: 'dummy_city',
          rating: 0.0,
          address: 'dummy_address',
          categories: [],
          menus: Menus(foods: [], drinks: []),
          customerReviews: [],
        ),
      ),
    );
  });
  testWidgets('Widget displays correct text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Restaurant Going Merry!'),
      ),
    ));

    expect(find.text('Restaurant Going Merry!'), findsOneWidget);
  });

  testWidgets('DetailPage displays customer reviews',
      (WidgetTester tester) async {
    final String restaurantId = "rqdv5juczeskfw1e867";
    final mockApiService = MockApiService();
    final mockRestaurantDetailProvider = MockRestaurantDetailProvider();

    when(mockRestaurantDetailProvider.state).thenReturn(
      RestaurantDetailResultStateData(
        DetailRestaurant(
          id: restaurantId,
          name: 'Test Restaurant',
          description: 'Test Description',
          pictureId: "14",
          city: 'Test City',
          rating: 4.5,
          address: 'Test Address',
          categories: [],
          menus: Menus(foods: [], drinks: []),
          customerReviews: [
            CustomerReview(
                name: 'Customer Name',
                review: 'Customer Review',
                date: '2021-01-01'),
          ],
        ),
      ),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider(
            create: (context) => mockApiService,
          ),
          Provider(
            create: (context) => LocalDatabaseService(),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                LocalDatabaseProvider(context.read<LocalDatabaseService>()),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteProvider(),
          ),
          ChangeNotifierProvider<RestaurantDetailProvider>(
            create: (context) => mockRestaurantDetailProvider,
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantReviewProvider(mockApiService),
          ),
        ],
        child: MaterialApp(
          home: DetailPage(restaurantId: restaurantId),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Reviews'), findsOneWidget);
    expect(find.text('Customer Name'), findsOneWidget);
    expect(find.text('Customer Review'), findsOneWidget);
  });
}
