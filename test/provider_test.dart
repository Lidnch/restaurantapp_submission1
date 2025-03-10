import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/service/api/api_services.dart';
import 'package:restaurant_app/model/menus.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant_detail_response.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';


class MockApiServices extends Mock implements ApiServices{}

void main() {
  group('RestaurantListProvider Test', () {
    late RestaurantListProvider provider;
    late MockApiServices mockApiServices;

    setUp(() {
      mockApiServices = MockApiServices();
      provider = RestaurantListProvider(mockApiServices);
    });

    test('Initial state should be none', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Fetching restaurant list should update state to Loaded', () async {
      final mockRestaurants = RestaurantListResponse(
          error: false,
          message: "Success",
          count: 1,
          restaurants: [
           RestaurantList(
             id: "1",
             name: "Mock Test Restaurant",
             city: "Mock Test City",
             pictureId: "mocktest.jpg",
             rating: 4.5,
           ),
          ],
      );

      when(() => mockApiServices.getRestaurantList())
          .thenAnswer((_) async => mockRestaurants);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
    });

    test('Fetching restaurant list should update state to Error when failed', () async {
      when(() => mockApiServices.getRestaurantList()).thenThrow(Exception('Failed to load'));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
    });
  });

  group('RestaurantDetailProvider Test', () {
    late RestaurantDetailProvider provider;
    late MockApiServices mockApiServices;

    setUp(() {
      mockApiServices = MockApiServices();
      provider = RestaurantDetailProvider(mockApiServices);
    });

    test('Initial state should be None', () {
      expect(provider.resultState, isA<RestaurantDetailNoneState>());
    });

    test('Fetching restaurant detail should update state to Loaded', () async {
      final mockDetailResponse = RestaurantDetailResponse(
          error: false,
          message: "Success",
          restaurant: RestaurantDetail(
              id: "1",
              name: "Mock Test Restaurant",
              description: "Very good mock restaurant",
              city: "Mock City",
              address: "Mock Address",
              pictureId: "mocktest.jpg",
              categories: [],
              menus: Menus(foods: [], drinks: []),
              rating: 4.5,
              customerReviews: []
          ),
      );

      when(() => mockApiServices.getRestaurantDetail("1"))
          .thenAnswer((_) async => mockDetailResponse);

      await provider.fetchRestaurantDetail("1");

      expect(provider.resultState, isA<RestaurantDetailLoadedState>());
    });

    test('Fetching restaurant detail should update state to Error when failed', () async {
      when(() => mockApiServices.getRestaurantDetail("1"))
          .thenThrow(Exception('Failed to load'));

      await provider.fetchRestaurantDetail("1");

      expect(provider.resultState, isA<RestaurantDetailErrorState>());
    });
  });

  group('FavoriteIconProvider Test', () {
    late FavoriteIconProvider provider;

    setUp(() {
      provider = FavoriteIconProvider();
    });

    test('Initial state should be not favorite', () {
      expect(provider.isFavorite, false);
    });

    test('Toggling favorite should update isFavorite', () {
      provider.isFavorite = true;
      expect(provider.isFavorite, true);
    });

    test('Setting isFavorite to false should update state', () {
      provider.isFavorite = false;
      expect(provider.isFavorite, false);
    });
  });
}