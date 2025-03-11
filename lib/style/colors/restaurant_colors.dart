import 'package:flutter/material.dart';

enum RestaurantColors {
  gold("Gold", Colors.orangeAccent),
  yellow('Yellow', Colors.yellow),
  blue('Blue', Colors.lightBlueAccent);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}