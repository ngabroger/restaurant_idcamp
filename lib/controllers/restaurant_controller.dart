import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/model/detail_restaurant.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  var restaurantList = <Restaurant>[].obs;
  var searchResult = <Restaurant>[].obs;

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
  var isListLoading = true.obs;
  var isDetailLoading = true.obs;
  var isSearchLoading = true.obs;

  var isError = false.obs;
  var errorMessage = "".obs;
  final ApiService apiService;
  RestaurantController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    fetchRestaurantList();
  }

  Future<void> fetchRestaurantList() async {
    try {
      isListLoading(true);
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
      isListLoading(false);
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      isDetailLoading(true);
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
      isDetailLoading(false);
    }
  }

  Future<void> searchRestaurant(String query) async {
    try {
      isSearchLoading(true);
      isError(false);
      var response = await apiService.searchRestaurant(query);
      if (response != null) {
        searchResult.value = response.restaurants;
      } else {
        isError(true);
        
        errorMessage.value = "Failed to search restaurant";
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString();
    } finally {
      isSearchLoading(false);
    }
  }
}
