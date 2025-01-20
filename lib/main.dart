import 'package:find_restaurant/controllers/dark_theme_provider.dart';
import 'package:find_restaurant/controllers/restaurant_detail_provider.dart';
import 'package:find_restaurant/controllers/restaurant_list_provider.dart';
import 'package:find_restaurant/controllers/restaurant_recent_provider.dart';
import 'package:find_restaurant/controllers/restaurant_review_provider.dart';
import 'package:find_restaurant/controllers/restaurant_search_provider.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/pages/detail_page.dart';
import 'package:find_restaurant/static/navigation_routes.dart';
import 'package:find_restaurant/style/theme/theme.dart';
import 'package:find_restaurant/style/typhograph/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => ApiService(),
    ),
    ChangeNotifierProvider(
      create: (context) => DarkThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantRecentProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantListProvider(context.read<ApiService>()),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantDetailProvider(context.read<ApiService>()),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantSearchProvider(context.read<ApiService>()),
    ),
    ChangeNotifierProvider(
        create: (context) =>
            RestaurantReviewProvider(context.read<ApiService>())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Ubuntu", "Ubuntu");
    final DarkThemeProvider darkThemeProvider =
        context.watch<DarkThemeProvider>();
    final materialTheme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkThemeProvider.darkTheme
          ? materialTheme.dark()
          : materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoutes.mainRoute.name,
      routes: {
        NavigationRoutes.mainRoute.name: (context) => MainPage(),
        NavigationRoutes.detailRoute.name: (context) => DetailPage(
              restaurantId:
                  ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}
