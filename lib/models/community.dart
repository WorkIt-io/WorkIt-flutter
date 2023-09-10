import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Community {
  final String id;
  final String name;
  final LatLng location;
  final String description;
  final String category;
  final String address;
  final DateTime date;
  final int? min;
  final int? max;
  List<String> images;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.address,
    required this.date,
    this.min,
    this.max,
    this.images = const [],
  });

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
        id: map['id'],        
        name: map['name'],
        description: map['description'],
        location: LatLng(map['lat'], map['lng']),
        category: map['category'],
        min: map['min'],
        address: map['address'],
        date: (map['date'] as Timestamp).toDate().toLocal(),
        images: List<String>.from(map['images']));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'lat': location.latitude,
      'lng': location.longitude,
      'category': category,
      'address': address,
      'min': min,
      'max': max,
      'date': date,
      'images': images,
    };
  }
}
