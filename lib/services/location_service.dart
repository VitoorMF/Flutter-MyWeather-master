import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myweather/models/weather_data.dart';

class LocationService {
  Future<WeatherData> getWeatherData() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied.');
      }
    }

    // Obter localização atual
    LocationData locationData = await location.getLocation();
    double latitude = locationData.latitude!;
    double longitude = locationData.longitude!;



    // Buscar dados de clima
    String apiKey = '8790ce359f567b1d06b8646dd12edd2f';
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);


      return WeatherData(
        cityName: data['name'],
        temperature: data['main']['temp'],
        climateDescription: data['weather'][0]['description'],
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}