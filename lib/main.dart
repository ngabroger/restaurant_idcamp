import 'package:find_restaurant/pages/detail_page.dart';
import 'package:find_restaurant/pages/home_page.dart';
import 'package:find_restaurant/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: NavigationRoutes.mainRoute.name,
      getPages: [
        GetPage(
          name: NavigationRoutes.mainRoute.name,
          page: () => MainPage(),
        ),
        GetPage(
          name: NavigationRoutes.detailRoute.name,
          page: () => DetailPage(restaurantId: Get.parameters['id']!),
        )
      ],
    );
  }
}
