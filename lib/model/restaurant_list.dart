class RestaurantList {
  String id;
  String name;
  String pictureId;
  String city;
  double rating;

  RestaurantList({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
    id: json["id"],
    name: json["name"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}