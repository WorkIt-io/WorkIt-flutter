import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepository();
});

class LocationRepository 
{  

  Future<http.Response> getAutoComplete(String input, String sessionToken, String countryCode)
  async {

    Uri url = Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json",
    {
      'input': input,      
      'sessiontoken': sessionToken,
      'components': 'country:$countryCode',
      'key': dotenv.env['API_KEY'],
    });

    
    final response = await http.get(url);
    return response;
  }

  // from billing side it is better to use detail request after 6 characters.
  Future<http.Response> getBusinessDetailsWithSpecificFields(String placeId) async { 
  final uri = Uri.https(
    'maps.googleapis.com',
    '/maps/api/place/details/json',
    {
      'place_id': placeId,
      'fields': 'formatted_address,name,geometry/location', 
      'key': dotenv.env['API_KEY'],  
    },
  );

  final response = await http.get(uri);
  return response;
}

  Future<http.Response> geoCoding(String address) async {
    final uri = Uri.https(
    'maps.googleapis.com',
    '/maps/api/geocode/json',
    {
      'address': address,
      'key': dotenv.env['API_KEY'],
    },
  );

  final response = await http.get(uri);
  return response;
  }



}