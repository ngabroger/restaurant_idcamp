import 'package:find_restaurant/controllers/favorite_controller/favorite_provider.dart';
import 'package:find_restaurant/controllers/favorite_controller/local_database_provider.dart';
import 'package:find_restaurant/controllers/page_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_detail_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_list_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_recent_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_review_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_search_provider.dart';
import 'package:find_restaurant/controllers/setting_provider.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/local/local_database_service.dart';
import 'package:find_restaurant/data/preferences/setting_preference.dart';
import 'package:find_restaurant/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late SettingProvider settingProvider;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    settingProvider = SettingProvider(
      settingPreference: SettingPreference(
        Future.value(sharedPreferences),
      ),
    );
  });

  testWidgets('Main screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider(create: (context) => ApiService()),
          Provider(create: (context) => LocalDatabaseService()),
          Provider(
              create: (context) => SettingPreference(
                  Future.value(SharedPreferences.getInstance()))),
          ChangeNotifierProvider(
              create: (context) =>
                  LocalDatabaseProvider(context.read<LocalDatabaseService>())),
          ChangeNotifierProvider(create: (context) => FavoriteProvider()),
          ChangeNotifierProvider(create: (context) => PageProvider()),
          ChangeNotifierProvider.value(value: settingProvider),
          ChangeNotifierProvider(
              create: (context) => RestaurantRecentProvider()),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantListProvider(context.read<ApiService>())),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantDetailProvider(context.read<ApiService>())),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantSearchProvider(context.read<ApiService>())),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantReviewProvider(context.read<ApiService>())),
        ],
        child: MaterialApp(
          home: MainPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Find Restaurant'), findsOneWidget);
  });

  testWidgets('Navigate to settings screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider(create: (context) => ApiService()),
          Provider(create: (context) => LocalDatabaseService()),
          Provider(
              create: (context) => SettingPreference(
                  Future.value(SharedPreferences.getInstance()))),
          ChangeNotifierProvider(
              create: (context) =>
                  LocalDatabaseProvider(context.read<LocalDatabaseService>())),
          ChangeNotifierProvider(create: (context) => FavoriteProvider()),
          ChangeNotifierProvider(create: (context) => PageProvider()),
          ChangeNotifierProvider.value(value: settingProvider),
          ChangeNotifierProvider(
              create: (context) => RestaurantRecentProvider()),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantListProvider(context.read<ApiService>())),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantDetailProvider(context.read<ApiService>())),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantSearchProvider(context.read<ApiService>())),
          ChangeNotifierProvider(
              create: (context) =>
                  RestaurantReviewProvider(context.read<ApiService>())),
        ],
        child: MaterialApp(
          home: MainPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Assuming there is a button or icon to navigate to the settings screen
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Setting User'), findsOneWidget);
  });
}
