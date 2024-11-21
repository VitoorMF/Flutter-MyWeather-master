import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String day;
  final String humidity;
  final IconData icon;
  final String temperature;
  final String description;
  final bool isToday;
  final String time;

  const CustomListItem({
    required this.day,
    required this.humidity,
    required this.icon,
    required this.temperature,
    required this.description,
    required this.isToday,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isToday ? Colors.blueAccent : Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(icon, color: Colors.white, size: 32),
          Text(
            '$temperature°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            'Humidity: $humidity%',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}