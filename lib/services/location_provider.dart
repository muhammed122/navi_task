import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocationProvider {

  static Future<Position> getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);

    // return Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high,
    //   forceAndroidLocationManager: true,
    //   timeLimit:Duration(seconds: 5)
    // );
  }

  static Future<String> getAddressFromLocation(LatLng latLng) async {
    final coordinates = Coordinates(latLng.latitude, latLng.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    return first.addressLine;
  }
}
