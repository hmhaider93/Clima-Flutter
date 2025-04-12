import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Location myLocation = Location();
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  String currentPostion = 'Get Location';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            //Get the current location
          setState(() {
            this.currentPostion = 'Current Position: ${myLocation.getLatitude()}, ${myLocation.getLongitude()}';
          });
          },
          child: Text(currentPostion),
        ),
      ),
    );
  }

  void getWeatherData() async {
    await myLocation.getCurrentLocation();
    double lat = myLocation.getLatitude();
    double lon = myLocation.getLongitude();
    String appId = '7cc836c5d71614301b98f20199f34eb6';
    // Response response = await get(Uri.parse('https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$appId'));
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var weather = data['weather'][0]['main'];
      var condition = data['weather'][0]['id'];
      var temperature = data['main']['temp'];
      var city = data['name'];
      print('Weather: $weather, Condition: $condition, Temperature: $temperature, City: $city');
    } else {
      print('Failed to load weather data');
    }
    print(response.statusCode);
    
  }

  /// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the 
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale 
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
  
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately. 
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   } 

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   print('Current Position: $position');
//   return position;
// }

}
