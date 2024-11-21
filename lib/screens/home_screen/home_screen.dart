import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myweather/services/location_service.dart';
import 'package:myweather/widgets/weather_info.dart';
import 'package:myweather/models/weather_data.dart';
import 'package:myweather/widgets/weather_days.dart';

import 'loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherData? weatherData;
  bool noData = false;
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initData();

    // Timer para resetar o estado a cada 10 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _initData();
    });
  }

  @override
  void dispose() {
    // Cancelar o Timer quando o widget for destruído
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initData() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Recarregar dados de clima
      weatherData = await LocationService().getWeatherData();
      setState(() {
        isLoading = false;
        noData = false;
      });
    } catch (e) {
      setState(() {
        noData = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text('Boa noite'),
      ),
      body:  weatherData == null
          ? const LoadingScreen()
          : Stack(
        children: [
          // Background and widgets
          SizedBox.expand(
            child: Image.asset(
              'assets/images/2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      noData == true ?  const WeatherInfo(
                        myCity: 'Erro de conexão',
                        myTemperature: '0°',
                        myClimate: '',
                      ) :
                      WeatherInfo(
                        myCity: weatherData!.cityName,
                        myTemperature: '${weatherData!.temperature.toInt()}°',
                        myClimate: weatherData!.climateDescription,
                      ),
                    ],
                  ),
                  const WeatherDays(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}