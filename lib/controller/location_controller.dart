import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workit/api/repository/location_repository.dart';

final locationControllerProvider = Provider<LocationController>((ref) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return LocationController(locationRepository);
});

class LocationController {
  LocationController(this._locationRepository);

  final LocationRepository _locationRepository;

  Future<List> getAutoCompletePlaces(String input, String sessionToken, String countryCode) async {
    List predictions = [];
    final response =
        await _locationRepository.getAutoComplete(input, sessionToken, countryCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      for (var prediction in (data['predictions'] as List)) {
        predictions.add(prediction);
      }
    }

    return predictions;
  }

  selectPlaceFromAuto(String placeId) async {
    final response =
        await _locationRepository.getBusinessDetailsWithSpecificFields(placeId);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['result'] != null) {
        return jsonResponse['result'];
      }
    }
    return 'not found';
  }

  Future<LatLng?> geoCoding(String address) async {
    final response = await _locationRepository.geoCoding(address);

    if (response.statusCode == 200)
    {
      final data = json.decode(response.body);

      if(data['status'] == 'OK')
      {
        final location = data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    }

    return null;
  }
}
