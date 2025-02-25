import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';

class MenuWidget extends StatelessWidget {
  final RestaurantDetail restaurant;
  const MenuWidget({
    super.key,
    required this.restaurant,
  });

@override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox.square(dimension: 4,),
        Text(
          "Food",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox.square(dimension: 4,),
        SizedBox(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount : restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                final foods = restaurant.menus.foods[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                      label: Text(
                          foods.name,
                          style: Theme.of(context).textTheme.labelMedium,
                      ),
                  ),
                );
              }
          ),
        ),
        const SizedBox.square(dimension: 4,),
        Text(
          "Drinks",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox.square(dimension: 4,),
        SizedBox(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount : restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                final drinks = restaurant.menus.drinks[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(
                      drinks.name,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}