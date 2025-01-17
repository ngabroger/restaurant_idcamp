import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/model/detail_restaurant.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  var restaurantList = <Restaurant>[].obs;

  var detailRestaurant = DetailRestaurant(
      id: '',
      name: '',
      description: '',
      city: '',
      address: '',
      pictureId: '',
      categories: [],
      menus: Menus(foods: [], drinks: []),
      rating: 0.0,
      customerReviews: []).obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  final ApiService apiService;
  RestaurantController({required this.apiService});

  @override
  void onInit() {
    fetchRestaurantList();
  }

  Future<void> fetchRestaurantList() async {
    try {
      isLoading(true);
      isError(false);
      var response = await apiService.getListRestaurant();
      if (response != null) {
        restaurantList.value = response.restaurants;
      } else {
        isError(true);
        errorMessage.value = "Failed to load list restaurant";
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      isLoading(true);
      isError(false);
      var response = await apiService.getDetailRestaurant(id);
      if (response != null) {
        detailRestaurant.value = response.restaurant;
      } else {
        isError(true);
        errorMessage.value = "Failed to load detail restaurant";
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
