import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/service/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetail? _restaurantDetail;

  RestaurantDetailResultState get resultState => _resultState;
  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);

      if(result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _restaurantDetail = result.restaurant;
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch(e) {
      _resultState = RestaurantDetailErrorState("Failed to load detail.");
      notifyListeners();
    }
  }
}