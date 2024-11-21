import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.myCity, required this.myTemperature, required this.myClimate});
  final String myCity;
  final String myTemperature;
  final String myClimate;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          children: [
            Text(
              myCity,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              myTemperature,
              style: const TextStyle(fontSize: 118),
            ),
            Text(
              myClimate,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
