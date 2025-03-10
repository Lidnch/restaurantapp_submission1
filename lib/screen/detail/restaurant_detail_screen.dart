import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:restaurant_app/screen/detail/body_of_restaurant_detail_widget.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';


class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<RestaurantDetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId.toString());
      context
          .read<RestaurantListProvider>()
          .fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => FavoriteIconProvider(),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadedState(data: var restaurant) =>
                      FavoriteIconWidget(restaurant: restaurant),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantDetailProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              RestaurantDetailLoadingState() => Center(
                  child: LoadingAnimationWidget.fourRotatingDots(color: Colors.orangeAccent, size: 45),
              ),
              RestaurantDetailLoadedState(data: var restaurant) =>
                  BodyOfDetailScreenWidget(restaurant: restaurant,),
              RestaurantDetailErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => const SizedBox(),
            };
          },
      ),
    );
  }
}

