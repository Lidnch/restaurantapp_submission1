import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_list.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantList restaurant;
  final Function() onTap;
  
  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Padding(
        padding: const EdgeInsets.symmetric(
           vertical: 8,
           horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 120,
                  minWidth: 120,
                  maxHeight: 80,
                  minHeight: 80,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        fit:  BoxFit.cover,
                    ),
                  ),
                ),
            ),
            const SizedBox.square(dimension: 8,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox.square(dimension: 6,),
                    Row(
                      children: [
                        const Icon(Icons.pin_drop_rounded,),
                        const SizedBox.square(dimension: 4,),
                        Expanded(
                            child: Text(
                                restaurant.city,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ),
                      ],
                    ),
                    const SizedBox.square(dimension: 6,),
                    Row(
                      children: [
                        const Icon(
                            Icons.star_rounded,
                          color: Colors.orangeAccent,
                        ),
                        const SizedBox.square(dimension: 6,),
                        Expanded(
                            child: Text(
                                restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}