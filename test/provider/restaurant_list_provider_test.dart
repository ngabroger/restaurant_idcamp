import 'package:find_restaurant/controllers/restaurant_controller/restaurant_list_provider.dart';
import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/model/list_restaurant_response.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:find_restaurant/static/restaurant_list_result_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late RestaurantListProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  group('RestaurantListProvider', () {
    test('Initial state should be RestaurantListResultStateInitial', () {
      expect(provider.state, isA<RestaurantListResultStateInitial>());
    });

    test('Should return restaurant list when API call is successful', () async {
      final restaurantList = [
        Restaurant(
            id: '1',
            name: 'Restaurant 1',
            rating: 4.8,
            pictureId: '1',
            city: 'City 1',
            description: 'Description 1'),
        Restaurant(
            id: '2',
            name: 'Restaurant 2',
            rating: 4.9,
            pictureId: '2',
            city: 'City 2',
            description: 'Description 2'),
      ];

      when(mockApiService.getListRestaurant())
          .thenAnswer((_) async => RestaurantListResponse(
                error: false,
                message: 'Success',
                count: 1,
                restaurants: restaurantList,
              ));

      await provider.fetchRestaurantList();

      expect(provider.state, isA<RestaurantListResultStateData>());
      expect((provider.state as RestaurantListResultStateData).restaurants,
          restaurantList);
    });

    test('Should return error when API call fails', () async {
      when(mockApiService.getListRestaurant())
          .thenAnswer((_) async => RestaurantListResponse(
                error: true,
                count: 1,
                message: 'Failed to load restaurants',
                restaurants: [],
              ));

      await provider.fetchRestaurantList();

      expect(provider.state, isA<RestaurantListResultStateError>());
      expect((provider.state as RestaurantListResultStateError).error,
          'Failed to load restaurants');
    });
  });
}
