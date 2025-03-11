import 'package:flutter/material.dart';
import 'package:restaurant_app/service/api/api_services.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();
  List<RestaurantList> _restaurants = [];

  RestaurantListResultState get resultState => _resultState;
  List<RestaurantList> get restaurants => _restaurants;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _restaurants = result.restaurants;
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch(e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}