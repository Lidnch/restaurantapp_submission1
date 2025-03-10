import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;

  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();

    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantValueById(widget.restaurant.id);
      final value = localDatabaseProvider.restaurant == null
          ? false
          : localDatabaseProvider.restaurant!.id == widget.restaurant.id;
      favoriteIconProvider.isFavorite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final localDatabaseProvider = context.read<LocalDatabaseProvider>();
          final favoriteIconProvider = context.read<FavoriteIconProvider>();
          final isFavorite = favoriteIconProvider.isFavorite;

          if(isFavorite) {
            await localDatabaseProvider.removeRestaurantValueById(widget.restaurant.id);
          } else {
            await localDatabaseProvider.saveRestaurantValue(widget.restaurant);
          }
          favoriteIconProvider.isFavorite = !isFavorite;
          localDatabaseProvider.loadAllRestaurantValue();
        },
        icon: Icon(
            context.watch<FavoriteIconProvider>().isFavorite
                ? Icons.favorite
                : Icons.favorite_outline,
        ),
    );
  }
}