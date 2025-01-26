import 'package:find_restaurant/controllers/page_provider.dart';
import 'package:find_restaurant/controllers/restaurant_controller/restaurant_recent_provider.dart';
import 'package:find_restaurant/controllers/schedule_controller.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RestaurantRecentProvider restaurantRecentProvider;

  setUp(() {
    restaurantRecentProvider = RestaurantRecentProvider();
  });

  test('addRecent should update recentRestaurant and notify listeners', () {
    final restaurant = Restaurant(
      id: '1',
      name: 'Test Restaurant',
      description: 'Test Description',
      pictureId: '1',
      city: 'Test City',
      rating: 4.5,
    );

    bool listenerCalled = false;
    restaurantRecentProvider.addListener(() {
      listenerCalled = true;
    });

    restaurantRecentProvider.addRecent(restaurant);

    expect(restaurantRecentProvider.recentRestaurant, restaurant);
    expect(listenerCalled, true);
  });

  group('PageProvider', () {
    late PageProvider pageProvider;

    setUp(() {
      pageProvider = PageProvider();
    });

    test('setPage should update page value and notify listeners', () {
      bool listenerCalled = false;
      pageProvider.addListener(() {
        listenerCalled = true;
      });

      pageProvider.setPage(2);

      expect(pageProvider.page, 2);
      expect(listenerCalled, true);
    });
  });

  group('ScheduleController', () {
    late ScheduleController scheduleController;

    setUp(() {
      scheduleController = ScheduleController();
    });

    test(
        'scheduleRestaurant should update isSelected value and notify listeners',
        () async {
      bool listenerCalled = false;
      scheduleController.addListener(() {
        listenerCalled = true;
      });

      await scheduleController.scheduleRestaurant(true);

      expect(scheduleController.isSelected, true);
      expect(listenerCalled, true);
    });
  });
}
