class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String pictureId;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        pictureId: json['pictureId'],
        rating: json['rating']?.toDouble(),
    );
  }
}