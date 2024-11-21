import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/my_day_item.dart';
import '../services/weather_days_service.dart';
import '../utils/weather_days_utils.dart';

class WeatherDays extends StatefulWidget {
  const WeatherDays({super.key});

  @override
  WeatherDaysState createState() => WeatherDaysState();
}

class WeatherDaysState extends State<WeatherDays> {
  final WeatherService _weatherService = WeatherService();
  List<dynamic> forecastData = [];
  Map<String, List<dynamic>> groupedForecast = {}; // Para agrupar por data

  @override
  void initState() {
    super.initState();
    _getWeatherForecast();
  }

  Future<void> _getWeatherForecast() async {


    try {
      final data = await _weatherService.fetchWeatherForecast();
      setState(() {
        forecastData = data; // Dados da previsão (intervalos de 3 horas)
        _groupForecastData(); // Agrupa as previsões por data
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _groupForecastData() {
    groupedForecast = WeatherDaysUtils.groupForecastData(forecastData);
  }

  String _formatDate(String date) {
    return WeatherDaysUtils.formatDate(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, // Faz o ListView se ajustar ao conteúdo
                padding: const EdgeInsets.all(8.0),

                itemCount: groupedForecast.keys.length,

                itemBuilder: (context, index) {
                  String date = groupedForecast.keys.elementAt(index);
                  String formattedDate = _formatDate(date); // Formata a data

                  List<dynamic> dailyForecast = groupedForecast[date]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate, // Exibe a data formatada
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Exibir previsões do mesmo dia em uma Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: dailyForecast.map((forecast) {
                              String time = DateFormat('HH:mm').format(DateTime.parse(forecast['dt_txt']));
                              String temperature = forecast['main']['temp'].toInt().toString();
                              String humidity =
                                  forecast['main']['humidity'].toString();
                              String description =
                                  forecast['weather'][0]['description'];

                              //TODO Set icon
                              String icon = forecast['weather'][0]['icon'];

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CustomListItem(
                                  day: formattedDate,
                                  time: time,
                                  humidity: humidity,
                                  //TODO Set icon according with forecast
                                  icon: Icons.cloud,
                                  temperature: temperature,
                                  description: description,
                                  isToday: false,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}