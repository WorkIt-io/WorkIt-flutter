import 'package:location/location.dart';

class Business {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double rate;
  final double distance;
  LocationData? location;   // when adding business we add location.
  final int price;


  Business({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rate,
    required this.distance,
    required this.price,
  });
}
