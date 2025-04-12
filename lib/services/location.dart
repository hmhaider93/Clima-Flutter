import 'package:geolocator/geolocator.dart';

class Location {
  late double _latitude;
  late double _longitude;

  @override
  String toString() {
    return 'Location(latitude: $_latitude, longitude: $_longitude)';
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  double getLatitude() {
    return _latitude ?? 0.0;
  }

  double getLongitude() {
    return _longitude ?? 0.0;
  }
}