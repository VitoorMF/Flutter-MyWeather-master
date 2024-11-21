import 'package:intl/intl.dart';

class WeatherDaysUtils {
  /// Agrupa os dados de previsão por data.
  static Map<String, List<dynamic>> groupForecastData(List<dynamic> forecastData) {
    Map<String, List<dynamic>> groupedForecast = {};

    for (var forecast in forecastData) {
      String date = forecast['dt_txt'].split(' ')[0]; // Extrai a data sem a hora
      if (!groupedForecast.containsKey(date)) {
        groupedForecast[date] = [];
      }
      groupedForecast[date]!.add(forecast);
    }

    return groupedForecast;
  }

  /// Formata a data no formato `dd/MM/yyyy`.
  static String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date); // Converte a string em DateTime
    return DateFormat('dd/MM/yyyy').format(parsedDate); // Formata para dd/MM/yyyy
  }
}