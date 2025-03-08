import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';
import 'package:restaurant_app/provider/detail/bookmark_icon_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;

  const BookmarkIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    super.initState();

    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantValueById(widget.restaurant.id);
      final value = localDatabaseProvider.restaurant == null
          ? false
          : localDatabaseProvider.restaurant!.id == widget.restaurant.id;
      bookmarkIconProvider.isBookmarked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final localDatabaseProvider = context.read<LocalDatabaseProvider>();
          final bookmarkIconProvider = context.read<BookmarkIconProvider>();
          final isBookmarked = bookmarkIconProvider.isBookmarked;

          if(isBookmarked) {
            await localDatabaseProvider.removeRestaurantValueById(parseInt(widget.restaurant.id));
          } else {
            await localDatabaseProvider.saveRestaurantValue(widget.restaurant);
          }
        },
        icon: icon);
  }
}