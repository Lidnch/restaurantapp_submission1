import 'package:flutter/material.dart';

enum RestaurantColors {
  gold("Gold", Colors.orangeAccent);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}