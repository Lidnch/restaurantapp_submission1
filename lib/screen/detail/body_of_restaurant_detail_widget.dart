import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/screen/detail/menus_widget.dart';
import 'package:restaurant_app/screen/detail/review_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
                      fit:  BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox.square(dimension: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.address,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.orangeAccent,
                      ),
                      const SizedBox.square(dimension: 4),
                      Text(
                        restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox.square(dimension: 4,),
              Row(
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: restaurant.categories.map((category) {
                      return Chip(
                        label: Text(
                            category.name,
                            style: Theme.of(context).textTheme.labelMedium,
                        ),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 0.1,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 0.5,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 16,),
              Text(
                restaurant.description,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox.square(dimension: 16,),
              MenuWidget(restaurant: restaurant),
              const SizedBox.square(dimension: 16,),
              ReviewWidget(restaurant: restaurant),
            ],
          ),
      ),
    );
  }
}