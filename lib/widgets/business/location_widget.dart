

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  LocationData? _locationData;
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = getImageMapUrl();
  }

  Future<String> getImageMapUrl() async {
    if (_locationData == null) await getLocation();

    final double lat = _locationData!.latitude!;
    final double lng = _locationData!.longitude!;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=400x400&markers=color:red%7Clabel:S%7C$lat,$lng&key=${dotenv.env['API_KEY']}";
  }

  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 300,
            width: 400,
            margin: const EdgeInsets.only(top: 30),            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              //border: Border.all(width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: snapshot.data!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Image.asset('assets/images/workit_logo_no_bg.png'),
              ),
            ),
          );
        } else {
          return const Text("There was an error");
        }
      },
    );
  }
}
