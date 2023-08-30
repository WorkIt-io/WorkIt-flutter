import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// class Business {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final String description;
//   final double rate;
//   final double distance;
//   LocationData? location; // when adding business we add location.
//   final int price;

//   Business({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.rate,
//     required this.distance,
//     required this.price,
//   });
// }

class BusinessModel {
  final String id;
  final String name;
  double rate;
  final LatLng location;
  final double price;
  final String description;
  final String category;
  final String address;
  final String phoneNumber;
  List<String> images;

  BusinessModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.price,
      required this.description,
      required this.rate,
      required this.location,
      required this.category,
      required this.address,
      this.images = const []
      });

  factory BusinessModel.fromMap(Map<String, dynamic> map)
  {
    
    return BusinessModel(id: map['id'], name: map['name'], phoneNumber: map['phone'] ,price: map['price']
    , description: map['description'], rate: map['rate'], location: LatLng(map['lat'], map['lng']), category: map['category'], address: map['address'],
    images: List<String>.from(map['images'])
    );
  }

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'name': name,
      'phone': phoneNumber,
      'price': price,
      'description': description,
      'rate': rate,
      'lat': location.latitude,
      'lng': location.longitude,
      'category': category,
      'address': address,
      'images': images,
    };
  }
}
