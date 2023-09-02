
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:workit/api/repository/location_repository.dart';


final userLocationNotifierProvider = StateNotifierProvider<UserLocationNotifier, LatLng?>((ref) => UserLocationNotifier(ref),
);


class UserLocationNotifier extends StateNotifier<LatLng?> {
  UserLocationNotifier(this._ref): super(null);

  final StateNotifierProviderRef _ref;
  
  Future<void> getCurrentLocation() async
  {
    if (state == null)
    {
      LocationData? myLocation = await _ref.read(locationRepositoryProvider).askPermission();
      if (myLocation == null) return;
      LatLng myLatLng = LatLng(myLocation.latitude!, myLocation.longitude!);
      state = myLatLng;
    }    
  }
}