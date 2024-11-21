import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class WeatherService {
  final String apiKey = '8790ce359f567b1d06b8646dd12edd2f';

  // Função para buscar a previsão do tempo
  Future<List<dynamic>> fetchWeatherForecast() async {
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

    // Get the current location
    LocationData locationData = await location.getLocation();
    double lat = locationData.latitude!;
    double lon = locationData.longitude!;

    String url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['list']; // Retorna os dados da previsão (intervalos de 3 horas)
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}