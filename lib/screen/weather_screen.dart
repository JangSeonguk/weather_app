import 'package:flutter/material.dart';
import 'package:weather_app/screen/weather_icon.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, this.parseWeatherData});
  final dynamic parseWeatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  int? temp;
  Widget? icon;
  WeatherIcon weatherIcon = WeatherIcon();

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic parseWeatherData) {
    cityName = parseWeatherData['name'];
    double temp2 = parseWeatherData['main']['temp'];
    temp = temp2.round();
    int condition = parseWeatherData['weather'][0]['id'];
    icon = weatherIcon.getWeatherIcon(condition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$cityName",
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "$temp\u2103",
                style: const TextStyle(
                    fontSize: 85,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
              icon != null ? icon as Widget : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
